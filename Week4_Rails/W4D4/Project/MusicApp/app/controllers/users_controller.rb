class UsersController < ApplicationController

  def new
    # @user is accessed in views new.html.erb, so whatever the user inputs in attribute value, gets stored in @user.
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user
      redirect_to session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by_email(email) # method missing
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
