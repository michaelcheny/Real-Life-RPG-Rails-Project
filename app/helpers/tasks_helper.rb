module TasksHelper

  def show_task_user(task)
    if task.user != current_user
      link_to task.user.username, user_path(task.user)
    end
  end


  def calculate_points(task)
    diff_pts = task.difficulty_level * 0.6
    pri_pts = task.priority_level * 0.8
    pts = (diff_pts + pri_pts) * 5
    return pts.to_i
  end


  def show_edit_button_for_task(task)
    if current_user == task.user
      link_to "Edit", edit_user_task_path(current_user, task), class: "btn btn-secondary btn-sm float-right"
    end
  end


  def show_delete_button_for_task(task)
    if params[:id]
      if current_user == task.user
        link_to "Delete", task, method: :delete, data: { confirm: "Are you sure?" }, class: "btn btn-secondary"
      end
    end
  end

  def tasks_that_are_not_yours
    Task.all.select{ |task| task.user != current_user }.reverse
  end


  def show_task_time_info(task)
    task.completed ? "Date of completion: " + task.completion_time : "added on: " + task.created_at.strftime("%m/%d/%Y").to_s
  end

  def show_completed_if_completed(task)
    task.completed ? "Completed" : "Not Completed"
  end


end
