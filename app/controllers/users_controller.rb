class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    redirect_to user_path(current_user.id)
  end

  def edit
    @user = current_user
    if @user == current_user
     render "edit"
    else
     redirect_to posts_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:introduction,:profile_image)
  end

end
