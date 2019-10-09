class ApplicationController < ActionController::Base

  helper_method :logged_in?
  helper_method :current_user
  helper_method :authenticate
  helper_method :authorize?

  private

  def current_user
    @user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authenticate
    if !logged_in? || current_user.nil?
      redirect_to login_path
    end
  end

  # checks if user is logged in and available
  def authorize?
    !current_user.nil? && !!logged_in?
  end
end
