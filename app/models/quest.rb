class Quest < ApplicationRecord
  has_many :user_quests
  has_many :users, through: :user_quests
  has_many :quest_skills
  has_many :skills, through: :quest_skills
end
