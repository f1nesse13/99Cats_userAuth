class SessionsController < ApplicationController
  before_action :already_logged_in, except: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    if login_user!(user_params)
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
