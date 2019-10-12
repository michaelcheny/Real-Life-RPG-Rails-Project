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
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Task created!"
      redirect_to user_task_path(@task.user)
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
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

