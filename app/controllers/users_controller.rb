class UsersController < ApplicationController

  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def followings # フォローしているユーザー
   @user = User.find(params[:id])
   @following_users = @user.following_users
  end
  
  def followers # フォローされているユーザー
    @user = User.find(params[:id])
    @follower_users = @user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end