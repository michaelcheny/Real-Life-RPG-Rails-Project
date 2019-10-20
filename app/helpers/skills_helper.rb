module SkillsHelper

  # Iterate over user's skills and trains the correct skill
  def update_user_skill(user, user_quest, points)

  quest = Quest.find_by(id: user_quest.quest_id)  
    user.user_skills.each do |user_skill|
      quest.skills.each do |quest_skill|

        if quest_skill.id == user_skill.skill_id

          train_skill(user_skill, points)

        end
      end
    end
  end


  def train_skill(user_skill, points)
    user_skill.update(experience_pts: update_skill(user_skill, points), level: calculate_level_from_exp(user_skill.experience_pts))
  end


  ## updates the skill 
  def update_skill(user_skill, points)
    user_skill.experience_pts += points
    return user_skill.experience_pts
  end


end
