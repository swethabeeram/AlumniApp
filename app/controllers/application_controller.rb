class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    session[:current_user]
  end
  helper_method :current_user

  def logged_in?
    session[:current_user].is_a?(User)
  end
  helper_method :logged_in?

  def check_logged_in
    if logged_in?
      return true
    else
      flash[:error] = "Sorry, you need to login to view the requested page!"
      redirect_to users_path
    end
  end

  def check_not_logged_in
    unless logged_in?
      return true
    else
      flash[:error] = "Sorry, you are already logged in."
      redirect_to users_path
    end
  end

end
