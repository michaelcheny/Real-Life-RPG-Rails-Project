class ApplicationController < ActionController::Base

  helper_method :logged_in?
  helper_method :current_user
  helper_method :authenticate
  helper_method :authorize?
  helper_method :check_if_user_is_a_master?
  # helper_method :owns_resource?

  rescue_from ActiveRecord::RecordNotFound, :with => :rescue404
  rescue_from ActionController::RoutingError, :with => :rescue404
 

  private

  # ERROR STUFF

  def rescue404
    render(:file => File.join(Rails.root, 'public/custom404.html'), :status => 404, :layout => false)
  end

  def rescue403
    render(:file => File.join(Rails.root, 'public/custom403.html'), :status => 403, :layout => false)
  end

  # def owns_resource?
  #   resource.user == current_user
  # end

  # def authorize(resource)
  #   rescue403 if !owns_resource?(resource)
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

  def authorize(user)
    unless params[:id].to_i == user.id
      flash[:error] = "You are not authorized! Sending you back."
      redirect_to dashboard_path
    end
  end


  # def authorize_viewing_quests
  #   unless params[:user_id].to_i == current_user.id
  #     flash[:error] = "You are not authorized to view this."
  #     redirect_to user_quests_path(current_user)
  #   end
  # end

  def authorize_viewing_nested(path_to)
    unless params[:user_id].to_i == current_user.id
      flash[:error] = "You are not authorized to view that. Shame! (ring bell)"
      redirect_to path_to
    end
  end

  # def authorize_quest(user_quest)
  #   unless current_user.id == user_quest.id
  #     flash[:error] = "You are not authorized! Sending you back."
  #     redirect_to dashboard_path and return
  #   end
  # end

  # ## authorizes user to edit user info, if not, redirect
  # def authorize_user_for_editing_user(user)
  #   authenticate
  #   redirect "/user/#{current_user.id}/edit" if !user
  #   redirect "/user/#{current_user.id}/edit" if current_user != user
  # end


  def authorize_task(task)
    # authenticate
    redirect_to edit_user_task_path(current_user, task) if !task
    redirect_to edit_user_task_path(current_user, task) if current_user != task.user
  end

  
  # Formula for leveling up based on exp
  def calculate_level_from_exp(exp_pts)
    level = (25 + (Math.sqrt(625 + 100 * exp_pts))) / 50
    return level.floor
  end


  def check_if_user_is_a_master?
    unless !!current_user && current_user.master
      flash[:error] = "You must become a master to do this action. Reach level 50 and defeat the mighty jelly bean to obtain master status."
      redirect_to dashboard_path
    end
  end

end
