class UsersController < ApplicationController
 before_action :valid_user, only: [:edit,:update]
   
  def show
    @user = User.find(params[id])
  end
  
  def followings
    logged_in_user
    @user = User.find(params[:id])
    @followings = @user.following_users
  end
  
  def followers
    logged_in_user
    @user = User.find(params[:id])
    @follower = @user.follower_users
  end

  def edit
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
      log_in @user
      redirect_to @user
    else
      render "new"
    end
  end
  
  def following
    current_user.following
  end
  
  def show
    @user = User.find(params[:id])
  end


  private
  
  def user_params
    params.require(:user).permit(:name , :email , :area,  :password , :password_confirmation)
  end
  
  def valid_user
     @user = User.find(params[:id])
     if @user != current_user
      flash[:danger] = "You can't edit other user's profile!!!!!!"
      redirect_to root_path 
     end
  end
  
end