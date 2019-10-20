module SkillsHelper

  

  ## updates the skill 
  def update_skill(user_skill, points)
    user_skill.experience_pts += points
    return user_skill.experience_pts
  end


end
