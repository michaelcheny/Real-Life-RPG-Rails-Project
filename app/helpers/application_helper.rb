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


  # Greeting
  def greeting
    if logged_in?
      "Hello " + current_user.username.titlecase
    end
  end

  
  # Shows how long it took for user to complete
  def show_object_time_info(object)
    object.completed ? "Date of completion: " + object.completion_time : "added on: " + object.created_at.strftime("%m/%d/%Y").to_s
  end

end
