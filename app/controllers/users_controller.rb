class UsersController < ApplicationController
  
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    
  end

  def new
    redirect_to dashboard_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params(:username, :password, :password_confirmation, :name, :email))
 
    if @user.save
      # to log in
      session[:user_id] = @user.id
      flash[:notice] = "Yo #{@user.username}!"
      redirect_to dashboard_path
    else
      flash[:error] = "nonono"
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def dashboard
    @user = current_user
  end

  private

  def user_params(*args)
    params.require(:user).permit(*args)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
