class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    if login_user!(user_params)
      redirect_to cats_url
    else
      flash[:errors] = "Username or password does not match"
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
