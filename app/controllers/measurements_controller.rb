# reference for filtering: http://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#advanced-queries
class MeasurementsController < ApplicationController
  before_action :set_measurement, only: %i[show update destroy]

  # GET /measurements
  # GET /measurements.json
  def index
    @measurements = Measurement.order(created_at: :asc)
    filter_by_ids params[:sensor_id]
    filter_by_created_at params[:created_after], params[:created_before]
    limit_count_per_sensor params[:last_per_sensor]
    limit_count params[:last]
  end

  def aggregated
    index
    @measurements = @measurements.group('DATE(created_at)').reorder('DATE(created_at)')
    @minimum_temperature = @measurements.minimum(:temperature)
    @maximum_temperature = @measurements.maximum(:temperature)
    @average_temperature = @measurements.average(:temperature).transform_values(&:to_f)
  end

  # GET /measurements/1
  # GET /measurements/1.json
  def show; end

  # POST /measurements
  # POST /measurements.json
  def create
    @measurement = Measurement.new(measurement_params)

    if @measurement.save
      render :show, status: :created, location: @measurement
    else
      render plain: @measurement.errors.to_json, content_type: 'application/json', status: :unprocessable_entity
    end
  end

  # PATCH/PUT /measurements/1
  # PATCH/PUT /measurements/1.json
  def update
    if @measurement.update(measurement_params)
      render :show, status: :ok, location: @measurement
    else
      render plain: @measurement.errors.to_json, content_type: 'application/json', status: :unprocessable_entity
    end
  end

  # DELETE /measurements/1
  # DELETE /measurements/1.json
  def destroy
    @measurement.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_measurement
    @measurement = Measurement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def measurement_params
    params.require(:measurement).permit(:temperature, :sensor_id, custom_attributes: {})
  end

  def filter_by_ids(ids)
    @measurements = @measurements.where(sensor_id: ids.split(',')) if ids.present?
  end

  def filter_by_created_at(created_after, created_before)
    from = Time.zone.parse(created_after.to_s) || 1_000.years.ago
    to = Time.zone.parse(created_before.to_s) || 1.second.from_now
    @measurements = @measurements.where(created_at: from..to)
  end

  def limit_count_per_sensor(last_per_sensor)
    @measurements = @measurements.last_per_sensor(last_per_sensor.to_i) if last_per_sensor.present?
  end

  def limit_count(last)
    @measurements = @measurements.last(last.to_i) if last.present?
  end
end
