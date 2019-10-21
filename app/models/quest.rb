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


  # Sort quest by level requirement to use in bulletin
  def self.sort_by_level_requirement
    order(level_requirement: :desc)
  end


  # Grabs the last five tasks
  def self.last_five
    limit(5)
  end  

  # Grabs the last three
  def self.last_three
    limit(3)
  end


  def completion_time
    self.updated_at.strftime("%m/%d/%Y")
  end

  def added_on
    self.created_at.strftime("%m/%d/%Y")
  end

end
