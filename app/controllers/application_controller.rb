class ApplicationController < ActionController::Base

  private

  def current_user
    # return unless session[:user_id]
    User.find_by(id: session[:user_id])
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
