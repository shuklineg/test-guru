class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  def authenticate_user!
    if logged_in?
      cookies.delete(:redirect_form) if cookies[:redirect_form]
    else
      cookies[:redirect_form] = request.fullpath if request.method == 'GET'
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
