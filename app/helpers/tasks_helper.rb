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

end
