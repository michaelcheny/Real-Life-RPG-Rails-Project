module ApplicationHelper


  # Better looking flash messages!
  def flash_class(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-danger"
      when 'alert' then "alert alert-warning"
    end
  end


  # Nav bar for log in and log out
  def navbar
    if logged_in?
      render 'layouts/logged_in_navbar'
    else
      render 'layouts/logged_out_navbar'
    end
  end


  # Greeting title
  def greeting
    if logged_in?
      "Hello " + current_user.username.titlecase
    end
  end

  
  # Shows how long it took for user to complete
  def show_object_time_info(object)
    object.completed ? "Date of completion: " + object.completion_time : "added on: " + object.created_at.strftime("%m/%d/%Y").to_s
  end


  # Shows link to boss battle
  def boss_battle_link
    if current_user.total_level >= 50
      render 'layouts/boss_battle_link'
    end
  end


  # Changes the link for the boss battle depend if you already defeated boss
  def beat_boss_button
    if current_user.master
      render 'shared/disabled_button', message: "You've already defeated the Evil Jellybean" 
    else
      submit_tag "Defeat the Jellybean and become a master", class: "btn btn-secondary btn-sm btn-block"
    end
  end


  ## For the rewards page for people over 50
  def show_if_master(user)
    if user.master
      render 'users/rewards_link'
    end
  end
  

end
