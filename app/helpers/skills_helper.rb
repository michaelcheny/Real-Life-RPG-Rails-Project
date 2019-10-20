module SkillsHelper

  # Iterate over user's skills and trains the correct skill
  def update_user_skill(user, points)

  end

  ## updates the skill 
  def update_skill(user_skill, points)
    user_skill.experience_pts += points
    return user_skill.experience_pts
  end


end
