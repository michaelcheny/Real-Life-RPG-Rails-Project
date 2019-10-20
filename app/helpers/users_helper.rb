module UsersHelper


  # sorts the total exp in decending order for the high score's list.
  def sort_by_total_exp(users)
    users.sort_by{|u| u.total_exp_pts}.reverse
  end


  # Returns the how far away the user's total level is from the quest requirements.
  def levels_away_from_req(user, quest)
    difference = quest.level_requirement - user.total_level
    return difference.to_s
  end


  # Returns true or false based on whether the user meets the quest requirements.
  def user_meets_requirements(user, quest)
    if user.total_level >= quest.level_requirement
      true
    else
      false
      flash[:error] = "You are " + levels_away_from_req(user, quest) + " levels are from the requirement."
      redirect_to quests_path
      return
    end
  end
  


end
