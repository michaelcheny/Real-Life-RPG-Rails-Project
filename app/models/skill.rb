class Skill < ApplicationRecord
  has_many :user_skills
  has_many :users, through: :user_skills
  has_many :task_skills
  has_many :skills, through: :task_skills
end
