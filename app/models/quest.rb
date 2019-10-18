class Quest < ApplicationRecord
  has_many :user_quests
  has_many :users, through: :user_quests
end
