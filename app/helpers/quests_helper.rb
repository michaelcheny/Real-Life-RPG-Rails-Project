module QuestsHelper

  def quest_footer_for_quest(quest)
    if params[:user_id]
      render 'quests/complete_button', object: quest.user_quests.find_by(params[:id]), url: "/complete_quest" 
    else
      if current_user.quests.include?(quest)
        render 'quests/already_added_button'
      else
        render 'quests/accept_quest_button', quest: quest
      end
    end
  end

end
