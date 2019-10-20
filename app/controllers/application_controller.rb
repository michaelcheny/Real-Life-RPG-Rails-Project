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
      flash[:error] = "You must be logged in."
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
    redirect_to edit_user_task_path(current_user, task) if !task
    redirect_to edit_user_task_path(current_user, task) if current_user != task.user
  end

  
  def authorize(user)
    if params[:user_id] != user.id.to_s
      flash[:error] = "You are not authorized! Sending you back."
      redirect_to user_tasks_path(user)
    end
  end


  ## not used yet
  def authorize_user(user)
    if user == current_user
      true
    else
      false
      no_access
      
    end
  end



  ## currently not working
  def no_access
    render(:file => File.join(Rails.root, 'public/custom403.html'), :status => 403, :layout => false)
  end


  # populates user skills with premade skills if empty
  def populate_skills_if_empty(user)
    if user.skills.empty?
      Skill.all.each do |s|
        user.skills << s
      end
    end
  end


  # ## updates the skill 
  # def update_skill(user_skill, points)
  #   user_skill.experience_pts += points
  #   return user_skill.experience_pts
  # end


  # def calculate_points_for(task)
  #   diff_pts = task.difficulty_level * 0.6
  #   pri_pts = task.priority_level * 0.8
  #   pts = (diff_pts + pri_pts) * 5
  #   return pts.to_i
  # end

  
  # Formula for leveling up based on exp
  def calculate_level_from_exp(exp_pts)
    level = (25 + (Math.sqrt(625 + 100 * exp_pts))) / 50
    return level.floor
  end


end
