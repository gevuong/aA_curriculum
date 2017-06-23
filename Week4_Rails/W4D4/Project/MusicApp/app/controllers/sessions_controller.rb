class SessionsController < ApplicationController
  # should reset the appropriate user's session_token
  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if user.nil?
      flash.now[:error] = "cannot find user"
      render :new_session_url
    else
      session[:session_token] = user.reset_session_token
      flash[:notice] = "successfully log in"
      redirect_to bands_url
    end
  end
end
