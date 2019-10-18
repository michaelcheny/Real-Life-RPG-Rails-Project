class Quest < ApplicationRecord
  has_many :user_quests
  has_many :users, through: :user_quests
  has_many :quest_skills
  has_many :skills, through: :quest_skills

  # accepts_nested_attributes_for :skills

  def skills_attributes=(skills_attributes)
    skills_attributes.values.each do |skill_attribute|
      skill = Skill.find_by(skill_attribute)
      self.skills << skill_attribute
    end
  end
end
