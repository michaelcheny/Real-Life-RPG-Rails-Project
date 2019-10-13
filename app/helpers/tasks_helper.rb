module TasksHelper

  def show_task_user(task)
    if task.user != current_user
      link_to task.user.username, user_path(task.user)
    end
  end

end
