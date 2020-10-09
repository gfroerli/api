module IosApp
  class SensorsController < ApplicationController
    def index
      @sensors = Sensor.order(created_at: :asc)
      @latest_sensor_temperatures = Measurement.last_per_sensor(1).pluck(:sensor_id, :temperature).to_h
    end

    def show
      @sensor = Sensor.joins(:measurements).group(:id)
                  .select(Sensor.attribute_names)
                  .select('MIN(measurements.temperature) AS minimum_temperature')
                  .select('MAX(measurements.temperature) AS maximum_temperature')
                  .select('AVG(measurements.temperature) AS average_temperature')
                  .find(params[:id])
      @latest_sensor_temperature = Measurement.where(sensor_id: params[:id]).order(created_at: :desc).first&.temperature
    end

    def aggregated_temperatures
      @aggregations = Measurement.where(sensor_id: params[:id]).group('DATE(created_at)').order('DATE(created_at) DESC')
                        .select('DATE(created_at) AS aggregation_date')
                        .select('MIN(measurements.temperature) AS minimum_temperature')
                        .select('MAX(measurements.temperature) AS maximum_temperature')
                        .select('AVG(measurements.temperature) AS average_temperature')
    end
  end
end
