class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    if logged_in? 
     @user = User.find(params[:id])
    else
     logged_in_user
    end
  end
  
  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      @user.save
      flash[:success] = "Your profile was updated!"
      redirect_to @user 
    else
      flash[:danger] = "Update was failed"
      render "edit"
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user #ユーザーページ
    else
      render "new"
    end
  end


  private
  
  def user_params
    params.require(:user).permit(:name , :email , :area,  :password , :password_confirmation)
  end
  
end