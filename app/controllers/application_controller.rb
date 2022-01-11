class ApplicationController < ActionController::Base
  before_action :authorize
  helper_method :current_user

  private

  def authorize
      redirect_to login_path, alert: 'You must be logged in to access this page.' if current_user.nil?
    end

  def current_user
    if session[:user_id]
      @current_user ||=User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

end
