class TasksController < ApplicationController

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user.nil?
        flash[:error] = "User not found"
        redirect_to users_path
      else
        @tasks = @user.tasks
      end
    else
      @tasks = Task.all
    end
  end


  def new
    authenticate
    create action isnt finding user_id, do something here to show user id
    @task = Task.new
  end

  def create
    authenticate
    binding.pry
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @task = Task.new(task_params)
      @user.tasks << @task
      binding.pry
      if @task.save
        flash[:notice] = "Task created, good job, #{@user.username}!"
        redirect_to user_task_path(@user, @task)
      else
        flash[:error] = "Sorry, #{@user.username}, something messed up."
        binding.pry
        render :new
      end
    end

    # @task = Task.new(task_params)
    # # 
    # if @task.save
    #   flash[:success] = "Task created!"
    #   redirect_to task_path(@task)
    # else
    #   flash[:error] = "Something messed up, try again."
    #   render :new
    # end
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

  end

  def update

  end

  def destroy

  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :difficulty_level, :priority_level)
  end
end

