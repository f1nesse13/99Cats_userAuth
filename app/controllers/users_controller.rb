class UsersController < ApplicationController
  before_action :already_logged_in

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user!(user_params)
      redirect_to cats_url
    else
      flash[:errors] = @user.errors.full_messages

      render :new
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
