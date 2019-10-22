module TasksHelper

  # shows the user's username.
  def show_task_user(task)
    if task.user != current_user
      link_to task.user.username, user_path(task.user)
    end
  end


  # Calculates point based on task info.
  def calculate_points(task)
    diff_pts = task.difficulty_level * 0.8
    pri_pts = task.priority_level * 0.8
    pts = (diff_pts + pri_pts) * 6
    return pts.to_i
  end


  # Shows edit button if user owns the task.
  def show_edit_button_for_task(task)
    if current_user == task.user
      if !task.completed
        link_to "Edit", edit_user_task_path(current_user, task), class: "btn btn-secondary btn-sm float-right"
      end
    end
  end


  # Shows the delete button if you own the task.
  def show_delete_button_for_task(task)
    if params[:id] && current_user == task.user
      link_to "Delete", task, method: :delete, data: { confirm: "Are you sure?" }, class: "btn btn-secondary"
    end
  end


  # Shows the complete button if user owns task.
  def show_complete_button_for(task)
    if current_user == task.user
      render 'shared/completed_button', object: task, url: user_task_path(task.user, task)
    end
  end


  # Gets all the task that don't belong to current user
  def tasks_that_are_not_yours
    Task.all.select{ |task| task.user != current_user }.reverse
  end



  # Shows completed or not completed.
  def show_completed_if_completed(task)
    task.completed ? "Completed" : "Not Completed"
  end


end
