module SkillsHelper

  # def update_skill(skill, task)
  #   binding.pry
  #   (skill.points) + (helpers.calculate_points(task))
  #   return skill.points
  # end


  ## updates the skill 
  def update_skill(user_skill, points)
    user_skill.experience_pts += points
    return user_skill.experience_pts
  end


end
