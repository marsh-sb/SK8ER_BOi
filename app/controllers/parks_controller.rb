class ParksController < ApplicationController

  def index
    @parks = Park.all
  end

  def show
    @park = Park.find(params[:id])
    @user = @park.user
  end

  def new
    @park = Park.new
  end

  def create
    @park = Park.new(park_params)
    @park.user_id = current_user.id
    if @park.save
      redirect_to park_path(@park)
    else
      render "new"
    end
  end


  private

  def park_params
    params.require(:park).permit(:park_image, :parkname, :parkbody, :address, :latitude, :longitude)
  end

end
