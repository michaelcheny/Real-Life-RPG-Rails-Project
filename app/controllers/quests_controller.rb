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


  end

  
  def update


  end


  def destroy


  end

  private

  def quest_params
    params.require(:quest).permit(:name, :description, :difficulty_level, :level_requirement, skill_ids:[])
  end

end
