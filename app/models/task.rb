class Task < ApplicationRecord

  validates :name, presence: true, length: { minimum: 2 }
  validates :description, length: { maximum: 500 }
 
  belongs_to :user
  has_many :task_skills
  has_many :skills, through: :task_skills

  accepts_nested_attributes_for :skills

  def skills_attributes=(skills_attributes)
    skills_attributes.values.each do |skill_attribute|
      skill = Skill.find_by(skill_attribute)
      self.skills << skill_attribute
    end
  end

  # scope :finished, where(:completed => true)

  def self.finished
    where(completed: true).order(updated_at: :desc)
  end

  def self.incomplete
    where(completed: false).order(created_at: :desc)
  end

  def completion_time
    self.updated_at.strftime("%b %e, %l:%M %p")
  end

  def duration
    created = self.created_at
    updated = self.updated_at
    minutes = (updated - created) / 1.minutes
    return minutes.round
  end
  
end
