class UsersController < ApplicationController
  
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
    @microposts = @user.microposts.order(created_at: :desc)
  end


  private
  
  def user_params
    params.require(:user).permit(:name , :email , :area,  :password , :password_confirmation)
  end
  
end