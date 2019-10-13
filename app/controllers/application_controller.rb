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

  def log_in(user)
    session[:user_id] = user.id
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

  ## authorizes user to edit user info, if not, redirect
  def authorize_user_for_editing_user(user)
    authenticate
    redirect "/user/#{current_user.id}/edit" if !user
    redirect "/user/#{current_user.id}/edit" if current_user != user
  end

  def authorize_task(task)
    # authenticate
    redirect_to user_tasks_path(current_user) if !task
    redirect_to user_tasks_path(current_user) if current_user != task.user
  end

  def authorize(user)
    redirect_to user_tasks_path(user) if params[:user_id] != user.id.to_s
  end

end
