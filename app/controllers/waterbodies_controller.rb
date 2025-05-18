class WaterbodiesController < ApplicationController
  def index
    @waterbodies = Waterbody.order(created_at: :asc)
  end

  def show
    @waterbody = Waterbody.find(params[:id])
  end
end
