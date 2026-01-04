class SponsorsController < ApplicationController
  before_action :set_sponsor, only: %i[show update destroy]
  rescue_from ArgumentError, with: :handle_invalid_enum

  # GET /sponsors
  # GET /sponsors.json
  def index
    @sponsors = Sponsor.order(created_at: :asc)
  end

  # GET /sponsors/1
  # GET /sponsors/1.json
  def show; end

  # POST /sponsors
  # POST /sponsors.json
  def create
    @sponsor = Sponsor.new(sponsor_params)

    if @sponsor.save
      render :show, status: :created, location: @sponsor
    else
      render plain: @sponsor.errors.to_json, content_type: 'application/json', status: :unprocessable_content
    end
  end

  # PATCH/PUT /sponsors/1
  # PATCH/PUT /sponsors/1.json
  def update
    if @sponsor.update(sponsor_params)
      render :show, status: :ok, location: @sponsor
    else
      render plain: @sponsor.errors.to_json, content_type: 'application/json', status: :unprocessable_content
    end
  end

  # DELETE /sponsors/1
  # DELETE /sponsors/1.json
  def destroy
    @sponsor.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sponsor
    @sponsor = Sponsor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sponsor_params
    params.expect(sponsor: [:name, :description, :active, :sponsor_type, { sensor_ids: [] }])
  end

  def handle_invalid_enum(exception)
    render json: { error: exception.message }, status: :bad_request
  end
end
