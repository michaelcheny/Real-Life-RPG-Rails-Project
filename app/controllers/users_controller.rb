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
    @user = User.new(user_params)
 
    if @user.save
      # to log in
      log_in(@user)
      flash[:success] = "Account successfully created!"

      Skill.all.each do |s|
        @user.skills << s
      end

      redirect_to dashboard_path
    else
      flash[:error] = "Please try again."
      render :new
    end
  end

  def edit
    authorize_user_for_editing_user(@user)
  end

  def update
    authorize_user_for_editing_user(@user)
    if @user.update(user_params)
      flash[:success] = "Profile successfully updated!"
      redirect_to dashboard_path
    else
      flash[:error] = "Please try again."
      render :edit
    end
  end

  def destroy

  end

  def dashboard
    authenticate
    @user = current_user
    #skill.user_skills.first.update(level: 1)
    
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :name, :email)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
