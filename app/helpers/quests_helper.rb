module QuestsHelper

  def quest_footer_for_quest(quest)
    if params[:user_id]
      render 'shared/completed_button', object: quest, url: user_quest_path(quest.user_quests.find_by(params[:user_id]), quest) 
    else
      if current_user.quests.include?(quest)
        render 'quests/already_added_button'
      else
        render 'quests/accept_quest_button', quest: quest
      end
    end
  end

end
