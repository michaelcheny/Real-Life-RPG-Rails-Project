class QuestsController < ApplicationController


  before_action :authenticate
  before_action :check_if_user_is_a_master?, except: [ :index, :show, :boss_battle, :defeated ]


  def index
    if params[:user_id]
      authorize_viewing_nested(user_quests_path(current_user))
      @user = current_user
      @quests = @user.quests
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
      flash[:error] = "Become a master first, bro."
      render :new
    end
  end


  def edit
    @user = current_user
    @quest = Quest.find(params[:id])
  end

  
  def update
    @user = current_user
    @quest = Quest.find(params[:id])
    if @quest.update(quest_params)
      flash[:success] = "Quest Updated."
      redirect_to user_quests_path(@user)
    else
      flash[:error] = "There was an error. Read the message below."
      render :edit
    end
  end


  def destroy
    @user = current_user
    @quest = Quest.find(params[:id])
    @quest.destroy
    flash[:success] = "#{@quest.name} has been deleted."
    redirect_to quests_path
  end


  def boss_battle
    
  end


  def defeated
    answer = "profanity"
    response = boss_battle_params[:input].downcase
    if answer == response
      current_user.update(master: true)
      flash[:success] = "Congrats! You've slain the boss and obtained the status of Master!"
      redirect_to dashboard_path
    else
      flash[:error] = "The Jellybean got what he wanted. Please try again."
      redirect_to bossbattle_path
    end
  end
  

  private


  def quest_params
    params.require(:quest).permit(:name, :description, :difficulty_level, :level_requirement, skill_ids:[])
  end


  def boss_battle_params
    params.permit(:input)
  end

end
