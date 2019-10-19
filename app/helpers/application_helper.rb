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


end
