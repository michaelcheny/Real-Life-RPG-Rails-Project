class QuestsController < ApplicationController


  before_action :authenticate


  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      if @user.nil?
        flash[:error] = "User not found."
        redirect_to quests_path
      else
        @quests = @user.quests
      end
    else
      @quests = Quest.all
    end
  end


  def show

  end


  def new
    @quest = Quest.new
  end


  def create
    @user = current_user
    @quest = Quest.new(quest_params)
    if @quest.save
      flash[:success] = "Quest has been created!"
      redirect_to quests_path
    else
      flash[:error] = "Sorry, you don't have the power to create a quest (ADD ADMIN FUNCTIONALITY)"
      render :new
    end
  end


  def edit
    @user = current_user
    authorize_user(@user)
    @quest = Quest.find(params[:id])
  end

  
  def update
    @user = current_user
    @quest = Quest.find(params[:id])
    if @quest.update(quest_params)
      flash[:error] = "Quest Updated."
      redirect_to user_quests_path(@user)
    else
      flash[:error] = "welp"
      redirect_to quest_path(@quest)
    end
  end


  def destroy

  end


  private


  def quest_params
    params.require(:quest).permit(:name, :description, :difficulty_level, :level_requirement, skill_ids:[])
  end


end
