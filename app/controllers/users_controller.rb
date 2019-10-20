class UsersController < ApplicationController
  
  include UsersHelper
  include QuestsHelper
  include SkillsHelper
  
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
      log_in(@user)
      flash[:success] = "Account successfully created!"
      populate_skills_if_empty(@user)
      redirect_to dashboard_path
    else
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
  end


  def highscores
    @users = User.all
  end


  def add_quest
    @quest = Quest.find(params[:quest][:id])
    @user = current_user
    if !@user.quests.include?(@quest)

      if user_meets_requirements(@user, @quest)
        @user.user_quests.create(quest: @quest) 
        flash[:success] = "Quest successfully added."
        redirect_to user_quests_path(@user)
      end

    else  ## to prevent people from inspecting page and enabling the button (extra precaution)
      flash[:error] = "You already have this quest added."
      redirect_to quests_path
    end
  end


  def complete_quest
    authenticate
    @user = current_user
    quest = Quest.find_by(id: params[:user_quest][:quest_id])


    @user.user_quests.each do |user_quest|
      # binding.pry
      if user_quest.quest_id == quest.id
        # binding.pry
        user_quest.update(user_quest_params)
        flash[:success] = "nice"


        redirect_to user_quests_path(@user)
        # binding.pry
      
        # # method to update user_quest.points, and add points to user_skill.
      end
    end
    # @quest = @user.user_quests.find_by(params[:user_quest][:id])
    # binding.pry
  end


  private


  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end


  def find_user
    @user = User.find(params[:id])
  end


  def user_quest_params
    params.require(:user_quest).permit(:completed)
  end


end
