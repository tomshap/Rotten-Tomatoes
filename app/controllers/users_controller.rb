class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.welcome_email(@user).deliver
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome to Rotten Mangoes, #{@user.firstname}! We're excited that you decided to join us."
    else
      render :new
    end unless admin_user?
  end

  def show
    @user = User.find(params[:id])
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

end
