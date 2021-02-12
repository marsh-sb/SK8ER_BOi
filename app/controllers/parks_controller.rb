class ParksController < ApplicationController

  def index
    @parks = Park.all
             .order(created_at: :desc)
             .page(params[:page]).per(10)
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

  def edit
    @park = Park.find(params[:id])
    if  @park.user == current_user
      render "edit"
    else
      redirect_to posts_path
    end
  end

  def update
    @park = Park.find(params[:id])
    if @park.update(park_params)
      redirect_to park_path(@park)
    else
      render :edit
    end
  end

  def destroy
    park = Park.find(params[:id])
    park.destroy
    redirect_to parks_path(park.user)
  end


  private

  def park_params
    params.require(:park).permit(:park_image, :parkname, :parkbody, :address, :latitude, :longitude)
  end

end
