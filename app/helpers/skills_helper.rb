module SkillsHelper

  # Iterate over user's skills, matche with the quest skills, and trains the correct skill
  def update_user_skill_quest(user, user_quest, points)
  quest = Quest.find_by(id: user_quest.quest_id)  
    user.user_skills.each do |user_skill|
      quest.skills.each do |quest_skill|

        if quest_skill.id == user_skill.skill_id

          train_skill(user_skill, points)
        end
      end
    end
  end


  # Update the user skill based on the task
  def update_user_skill_task(task_skill, task)
    task.user.user_skills.each do |user_skill|
      train_skill(user_skill, task_skill.points) if task_skill.skill_id == user_skill.skill_id
    end
  end


  ## Updates the experience points and level of that user_skill.
  def train_skill(user_skill, points)
    user_skill.update(experience_pts: update_skill(user_skill, points), level: calculate_level_from_exp(user_skill.experience_pts))
  end


  ## updates the skill 
  def update_skill(user_skill, points)
    user_skill.experience_pts += points
    return user_skill.experience_pts
  end


  ## Populates the user with skills if it is empty, usually in the beginning of a session or new user.
  def populate_skills_if_empty(user)
    if user.skills.empty?
      Skill.all.each do |s|
        user.skills << s
      end
    end
  end


end
