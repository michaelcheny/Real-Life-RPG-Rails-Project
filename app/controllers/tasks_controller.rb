class TasksController < ApplicationController


  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user.nil?
        flash[:error] = "User not found"
        redirect_to users_path
      else
        @finished_tasks = @user.tasks.finished
        @todo = @user.tasks.incomplete
      end
    else
      # binding.pry
      @tasks = Task.all
    end
  end


  def new
    authenticate
    @user = current_user
    @task = @user.tasks.build
  end


  def create
    authenticate
    if params[:user_id]
      @user = current_user
      ## if user.id != params of userid, throw 403
      authorize(@user)
      @task = @user.tasks.build(task_params)
      if @task.save
        flash[:success] = "Task created, good job, #{@user.username}!"
        redirect_to user_tasks_path(@user)
      else
        flash[:error] = "Sorry, #{@user.username}, something messed up."
        binding.pry
        # redirect_to new_user_task_path(current_user)
        render :new
      end
    else
      flash[:error] = "Sorry, #{@user.username}, something messed up."
      binding.pry
      redirect_to new_user_task_path(current_user)
    end

  end


  def show
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @task = @user.tasks.find_by(id: params[:id])
      if @task.nil?
        flash[:error] = "Task not found."
        redirect_to user_tasks_path(@user)
      end
    else
      @task = Task.find(params[:id])
    end
  end


  def edit
    authenticate
    if params[:user_id]
      @user = current_user
      authorize(@user)
      if @user.tasks.find_by(id: params[:id])
        @task = @user.tasks.find(params[:id])
        authorize_task(@task)
      else 
        flash[:error] = "Task not found, don't you dare."
         redirect_to user_tasks_path(@user) 
      end
    else
      flash[:error] = "User not found."
      redirect_to user_tasks_path(@user)
    end
  end


  def update
    @task = Task.find(params[:id])
    authorize_task(@task)
    @user = current_user

    if @task.update(task_params)
      flash[:success] = "Task updated successfully!"

      #update the point thing
      if @task.completed
        @task.task_skills.each do |task_skill|
         
          task_skill.update(points: calculate_points_for(@task))
         
          @task.user.user_skills.each do |user_skill|
           
            if task_skill.skill_id == user_skill.skill_id
              
              user_skill.update(experience_pts: update_skill(user_skill, task_skill.points), level: calculate_level_from_exp(user_skill.experience_pts)) 
              
            end
          end
        end
      end

      redirect_to user_tasks_path(@task.user)
    else
      flash[:error] = "Sorry, #{@task.user.username}, something messed up."
      # redirect_to edit_user_task_path(@task.user, @task)
      render :edit
    end
  end


  def destroy
    @task = Task.find(params[:id])
    authorize_task(@task)
    @task.destroy
    flash[:success] = "#{@task.name} has been deleted."
    redirect_to user_tasks_path(current_user)
  end


  private

  def task_params
    params.require(:task).permit(:name, :description, :difficulty_level, :priority_level, :completed, skill_ids:[])
  end
end

