class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # expose current_user method to views
  helper_method :current_user

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    return true unless current_user.nil?
  end

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token
  end
end
