class Skill < ApplicationRecord
  has_many :user_skills
  has_many :users, through: :user_skills
  has_many :task_skills
  has_many :skills, through: :task_skills
  has_many :quest_skills
  has_many :quests, through: :quest_skills

end
