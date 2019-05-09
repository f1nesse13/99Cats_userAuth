class ApplicationController < ActionController::Base
  helper_method :current_user, :login_user!, :can_approve?

  def current_user
    current_user ||= User.find_by(session_token: self.session[:session_token])
  end

  def login_user!(credentials)
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    return nil if user.nil?
    self.session[:session_token] = user.reset_session_token!
  end

  def already_logged_in
    if current_user
      redirect_to cats_url
    end
  end

  def logged_in?
    if current_user.nil?
      redirect_to new_session_url
    end
  end

  def can_approve?
    CatRentalRequest.find(params[:id]).cat.owner == current_user
  end

  def cat_owned?
    if current_user.cats.where({ id: params[:id] }).empty?
      flash[:errors] = "You must be the owner to do that!"
      redirect_to cats_url
    end
  end
end
