class TasksController < ApplicationController

  include TasksHelper
  include SkillsHelper
  include UsersHelper

  before_action :authenticate


  def index
    if params[:user_id]
      authorize_viewing_nested(user_tasks_path(current_user))
      @user = current_user
      @tasks = @user.tasks
    else
      @tasks = tasks_that_are_not_yours
    end
  end


  def new
    @user = current_user
    @task = @user.tasks.build
  end


  def create
    @user = current_user
    authorize(@user, params[:user_id])
    if params[:user_id]
      
      @task = @user.tasks.build(task_params)
      if @task.save
        flash[:success] = "Task created."
        redirect_to user_tasks_path(@user)
      else
        flash[:error] = "Something went wrong. See error below."
        render :new
      end
    else # just in case someone tries to create a non nested task.
      flash[:error] = "Sorry, #{@user.username}, something messed up."
      redirect_to new_user_task_path(current_user)
    end
  end


  def edit
    @user = current_user
    authorize(@user, params[:user_id])
    if params[:user_id]
      if @user.tasks.find_by(id: params[:id])
        @task = @user.tasks.find(params[:id])
        authorize_task(@task)
      else 
        flash[:error] = "Task not found."
        redirect_to user_tasks_path(@user) 
      end
    end
  end


  def update
    current_level = current_user.total_level
    @task = Task.find(params[:id])
    authorize_task(@task)

    if @task.update(task_params)
      flash[:success] = "Task updated successfully!"

      if @task.completed
        @task.task_skills.each do |task_skill|
         
          points = calculate_points(@task)
          task_skill.update(points: points)
         
          update_user_skill_task(task_skill, @task)
          leveled_up_message(current_user, current_level, points)
        end
      end
      redirect_to user_tasks_path(@task.user)
    else
      flash[:error] = "Sorry, #{@task.user.username}, something messed up."
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

