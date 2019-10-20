class Quest < ApplicationRecord

  has_many :user_quests
  has_many :users, through: :user_quests
  has_many :quest_skills
  has_many :skills, through: :quest_skills

  accepts_nested_attributes_for :skills

  validates :name, presence: true
  validates :description, length: { maximum: 500 }
  validates :skills, presence: true
  validates :skills, length: { maximum: 3, message: "You can only train up to 3 skills per quest." }


  def self.sort_by_level_requirement
    order(level_requirement: :desc)
  end


  def self.sort_by_completed
    where(completed: true)
  end


end
