module QuestsHelper

  def quest_footer_for_quest(quest)
    if params[:user_id]
      "render add button to complete task here"
    else
      if current_user.quests.include?(quest)
        render 'quests/already_added_button'
      else
        render 'quests/accept_quest_button', quest: quest
      end
    end
  end

end
