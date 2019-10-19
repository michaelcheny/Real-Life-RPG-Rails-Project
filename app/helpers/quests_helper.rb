module QuestsHelper

  def quest_footer_for_quest(quest)
    if params[:user_id]
      if quest
        render 'quests/disabled_button', message: "Completed"
      else
        render 'quests/complete_button', object: quest.user_quests.find_by(id: params[:id]), url: "/complete_quest" 
      end
    else
      if current_user.quests.include?(quest)
        render 'quests/disabled_button', message: "Already Added"
      else
        render 'quests/accept_quest_button', quest: quest
      end
    end
  end

end
