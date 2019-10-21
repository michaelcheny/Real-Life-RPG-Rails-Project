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
  
  
  # If user level up, show them their level, if not, show exp gained.
  def leveled_up_message(user, current_level, points)
    if user.total_level > current_level
      flash[:success] = "You are now level #{user.total_level}!"
    else
      flash[:success] = "#{points} exp gained for associated skills!"
    end
  end

  # Formula for leveling up based on exp
  def calculate_level_from_exp(exp_pts)
    level = (25 + (Math.sqrt(625 + 100 * exp_pts))) / 50
    return level.floor
  end


  # Dashboard Greeting
  def dashboard_greet(user)
    if user.master
      "The Great and Powerful #{user.username}"
    else
      "#{user.username}"
    end
  end


end
