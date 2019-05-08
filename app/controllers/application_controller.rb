class ApplicationController < ActionController::Base
  helper_method :current_user, :login_user!

  def current_user
    current_user ||= User.find_by(session_token: self.session[:session_token])
  end

  def login_user!(credentials)
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    self.session[:session_token] = user.reset_session_token!
  end

  def already_logged_in
    if current_user
      redirect_to cats_url
    end
  end
end
