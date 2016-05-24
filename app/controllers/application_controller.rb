class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def restrict_non_admins
    unless admin?
      redirect_to root_path, notice: "You must be an admin to access those pages"
    end
  end 

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin?
    @current_user.admin == true if @current_user
  end

  helper_method :admin?
  helper_method :current_user
end
