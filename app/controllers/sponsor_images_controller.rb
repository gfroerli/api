class SponsorImagesController < ApplicationController
  before_action :set_sponsor_image, only: %i[show update destroy]

  # GET /sponsor_images/1
  # GET /sponsor_images/1.json
  def show
    send_data @sponsor_image.file_contents, type: @sponsor_image.content_type
  end

  # POST /sponsor_images
  # POST /sponsor_images.json
  def create
    @sponsor_image = SponsorImage.new(sponsor_image_params)

    if @sponsor_image.save
      head :created, location: @sponsor_image
    else
      render json: @sponsor_image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sponsor_images/1
  # PATCH/PUT /sponsor_images/1.json
  def update
    if @sponsor_image.update(sponsor_image_params)
      head :ok, location: @sponsor_image
    else
      render json: @sponsor_image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sponsor_images/1
  # DELETE /sponsor_images/1.json
  def destroy
    @sponsor_image.destroy
  end

  private

  def set_sponsor_image
    @sponsor_image = SponsorImage.find(params[:id])
  end

  def sponsor_image_params
    params.require(:sponsor_image).permit(:sponsor_id, :file)
  end
end
