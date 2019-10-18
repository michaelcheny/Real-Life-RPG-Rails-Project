class QuestsController < ApplicationController

  def index
    @quest = Quest.all
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
    require(:quest).permit(:name, :description, :difficulty_level, :level_requirement, skills_ids:[])
  end

end
