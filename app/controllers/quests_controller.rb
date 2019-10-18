class QuestsController < ApplicationController

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      # @quests = Quest.all
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
    authenticate
    @quest = Quest.new
  end


  def create
    authenticate
    @user = current_user
    # @quest = @user.quests.build(quest_params)
    binding.pry
    @quest = Quest.new(quest_params)
    if @quest.save
      flash[:success] = "Quest has been created!"
      redirect_to quests_path
    else
      flash[:error] = "Sorry, you don't have the power to create a quest (ADD ADMIN FUNCTIONALITY)"
      redirect_to dashboard_path
    end
  end


  def edit
    authenticate
    @user = current_user
    authorize(@user)
    @quest = Quest.find(params[:id])
  end

  
  def update
    authenticate
    @user = current_user
    @quest = Quest.find(params[:id])
    binding.pry
    if @quest.update(quest_params)
      binding.pry
      redirect_to user_quests_path(@user)
    else
      flash[:error] = "welp"
      redirect_to quest_path(@quest)
    end

  end


  def destroy


  end


  def add_quest
    # binding.pry
    @quest = Quest.find(params[:quest][:id])
    @user = current_user
    # @user.quests.build()
    @user.quests << @quest
    # binding.pry
    redirect_to user_quests_path(@user)
  end

  private

  def quest_params
    params.require(:quest).permit(:name, :description, :difficulty_level, :level_requirement, skill_ids:[])
  end


end
