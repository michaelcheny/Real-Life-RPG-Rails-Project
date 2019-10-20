class UsersController < ApplicationController
  
  include UsersHelper
  include QuestsHelper
  include SkillsHelper
  
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:show, :new, :create, :highscores]
  before_action :authorize?, only: [:edit, :update]


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
  end


  def update
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
    @user = current_user
    quest = Quest.find_by(id: params[:user_quest][:quest_id])
    current_level = @user.total_level

    @user.user_quests.each do |user_quest|

      if user_quest.quest_id == quest.id

        user_quest.update(user_quest_params)
        points = calculate_points_for_quest(quest)

        if update_user_skill_quest(@user, user_quest, points)
          leveled_up_message(@user, current_level, points)
          redirect_to user_quests_path(@user)
        end
      end
    end
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
