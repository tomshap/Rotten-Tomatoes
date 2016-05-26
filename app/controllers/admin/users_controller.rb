class Admin::UsersController < ApplicationController

  before_action :restrict_access, except: [:switch_to_admin]

  def index
    @users = User.order("firstname").page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end 

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "#{@user.firstname} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def switch_to_user
    session[:admin_id] = current_user.id
    session[:user_id] = params[:id]

    redirect_to movies_path
  end

  def switch_to_admin
    if session[:admin_id]   
      session[:user_id] = session[:admin_id]
      session[:admin_id] = nil
    end
    redirect_to admin_users_path
  end
  
protected

  def require_admin
    unless current_user.admin?
      flash[:error] = "You must be an administrator to access this section"
      redirect_to movies_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin_user)
  end

end
