module ApplicationHelper

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
