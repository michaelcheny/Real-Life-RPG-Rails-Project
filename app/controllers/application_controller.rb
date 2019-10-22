class ApplicationController < ActionController::Base

  helper_method :logged_in?
  helper_method :current_user
  helper_method :authenticate
  helper_method :authorize?
  helper_method :check_if_user_is_a_master?

  # rescue_from ActiveRecord::RecordNotFound, :with => :rescue404
  # rescue_from ActionController::RoutingError, :with => :rescue404
 

  private

  # def rescue404
  #   render(:file => File.join(Rails.root, 'public/custom404.html'), :status => 404, :layout => false)
  # end


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
      flash[:error] = "You must be logged in."
      redirect_to login_path
    end
  end


  # checks if user is authorized
  def authorize?
    unless current_user.id == params[:id].to_i
      flash[:error] = "You are not authorized! Sending you back."
      redirect_to dashboard_path
    end
  end


  def authorize(user, id)
    unless id.to_i == user.id
      flash[:error] = "You are not authorized! Sending you back."
      redirect_to dashboard_path
    end
  end


  def authorize_viewing_nested(path_to)
    unless params[:user_id].to_i == current_user.id
      flash[:error] = "You are not authorized to view that. Shame! (ring bell)"
      redirect_to path_to
    end
  end


  def authorize_task(task)
    redirect_to edit_user_task_path(current_user, task) if !task
    redirect_to edit_user_task_path(current_user, task) if current_user != task.user
  end


  def check_if_user_is_a_master?
    unless !!current_user && current_user.master
      flash[:error] = "You must become a master to do this action. Reach level 50 and defeat the mighty jelly bean to obtain master status."
      redirect_to dashboard_path
    end
  end

end
