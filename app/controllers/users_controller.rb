class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    if session[:user_id] == @user.id
      @user = User.find(params[:id])
    else
      # 他のユーザーの基本情報の編集画面は表示できません
      redirect_to root_path , notice: '他のユーザーの基本情報の編集画面は表示できません'
    end
  end
  
  def update
    if session[:user_id] == @user.id
      # ログインしているユーザーの情報を変更
      if @user.update(user_params)
        # 保存に成功した場合はトップページへリダイレクト
        redirect_to root_path , notice: '基本情報を編集しました'
      else
        # 保存に失敗した場合は編集画面へ戻す
        render 'edit'
      end
    else
      #他のユーザーの情報は変更不可
        redirect_to root_path , notice: '他のユーザーの基本情報は編集できません'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile, :country)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
