class SkillsController < ApplicationController


  def index
    if params[:user_id]
      @skills = User.find(params[:user_id]).skills
    else
      @skills = SKill.all
    end
  end



  def show
    @skill = Skill.find(params[:id])
  end


end
