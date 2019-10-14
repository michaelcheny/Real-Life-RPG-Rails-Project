class Task < ApplicationRecord
 
  belongs_to :user
  has_many :task_skills
  has_many :skills, through: :task_skills

  # scope :finished, where(:completed => true)

  def self.finished
    where(completed: true)
  end

  def self.incomplete
    where(completed: false)
  end

  
end
