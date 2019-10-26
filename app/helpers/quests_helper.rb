module QuestsHelper

  # renders the footer of the quest based on different scenerios
  def quest_footer_for_quest(quest)
    if params[:user_id] 
      if quest.completed
        render 'shared/disabled_button', message: "Completed"
      else
        render 'quests/complete_button', object: quest, url: "/complete_quest" 
      end
    else
      if current_user.quests.include?(quest)
        render 'shared/disabled_button', message: "Accepted", class: "btn btn-secondary btn-sm btn-block"
      else
        render 'quests/accept_quest_button', quest: quest
      end
    end
  end


  # Quest footer for the show and dashboard page changes if it is you or others
  def quest_footer_for_show_dash(quest)
    if current_user.user_quests.include?(quest)
      render 'quests/complete_button', object: quest, url: '/complete_quest'
    end
  end

  # Calculates the exp earned for completing the quest based on quest info.
  def calculate_points_for_quest(quest)
    diff_pts = quest.difficulty_level * 1.2
    level_scaling = quest.level_requirement
    pts = (diff_pts + level_scaling) * 20
    return pts.to_i
  end


  # Gets duration of the task
  def duration(quest)
    created = quest.created_at
    updated = quest.updated_at
    minutes = (updated - created) / 1.minutes
    return minutes.round
  end


  # Shows the edit button for the quest
  def edit_button_for_quest(quest)
    if !!current_user && current_user.master
      link_to "Edit", edit_quest_path(quest), class: "btn btn-secondary btn-sm" 
    end
  end

  # Shows the delete button if you own the task.
  def show_delete_button_for_quest(quest)
    if params[:id] && current_user.master
      link_to "Delete", quest, method: :delete, data: { confirm: "Are you sure?" }, class: "btn btn-secondary"
    end
  end

end


