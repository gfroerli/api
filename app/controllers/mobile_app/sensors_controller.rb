module MobileApp
  class SensorsController < ApplicationController
    def index
      @sensors = Sensor.order(created_at: :asc)
      @latest_sensor_measurements = Measurement.last_per_sensor(1)
                                               .pluck(:sensor_id, :temperature, :created_at)
                                               .map { |fields| [
                                                 fields[0],
                                                 {
                                                   temperature: fields[1],
                                                   created_at: fields[2],
                                                 }
                                               ]}
                                               .to_h
    end

    def show
      @sensor = Sensor.joins(:measurements).group(:id)
                      .select(Sensor.attribute_names)
                      .select('MIN(measurements.temperature) AS minimum_temperature')
                      .select('MAX(measurements.temperature) AS maximum_temperature')
                      .select('AVG(measurements.temperature) AS average_temperature')
                      .find(params[:id])
      @latest_sensor_temperature = Measurement.where(sensor_id: params[:id]).order(created_at: :desc).first&.temperature
      @latest_measurement_at = Measurement.where(sensor_id: params[:id]).order(created_at: :desc).first&.created_at
    end

    def daily_temperatures
      @aggregations = Measurement.where(sensor_id: params[:id])
                                 .group('DATE(created_at)')
                                 .order('DATE(created_at) DESC')
                                 .select('DATE(created_at) AS aggregation_date')
                                 .select('MIN(measurements.temperature) AS minimum_temperature')
                                 .select('MAX(measurements.temperature) AS maximum_temperature')
                                 .select('AVG(measurements.temperature) AS average_temperature')
      @aggregations = filtered_by_params(@aggregations)
    end

    def hourly_temperatures
      @aggregations = Measurement.where(sensor_id: params[:id])
                                 .group('DATE(created_at)')
                                 .order('DATE(created_at) DESC')
                                 .select('DATE(created_at) AS aggregation_date')
                                 .group('EXTRACT(HOUR FROM created_at)')
                                 .order('EXTRACT(HOUR FROM created_at) DESC')
                                 .select('EXTRACT(HOUR FROM created_at)::integer AS aggregation_hour')
                                 .select('MIN(measurements.temperature) AS minimum_temperature')
                                 .select('MAX(measurements.temperature) AS maximum_temperature')
                                 .select('AVG(measurements.temperature) AS average_temperature')
      @aggregations = filtered_by_params(@aggregations)
    end

    def sponsor
      @sponsor = Sponsor.joins(:sensors).find_by!(sensors: { id: params[:id] }, active: true)
    end

    private

    def filtered_by_params(measurements)
      measurements.where(created_at: created_from_param..created_to_param).limit(limit_param)
    end

    def created_from_param
      Time.zone.parse(params[:from].to_s)&.beginning_of_day || DateTime.new(1989, 4, 7)
    end

    def created_to_param
      Time.zone.parse(params[:to].to_s)&.end_of_day || Time.zone.now
    end

    def limit_param
      limit = params[:limit].to_i
      limit.positive? ? limit : 10
    end
  end
end
