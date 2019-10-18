class Task < ApplicationRecord

  validates :name, presence: true, length: { minimum: 2 }
  validates :description, length: { maximum: 500 }
 
  belongs_to :user
  has_many :task_skills
  has_many :skills, through: :task_skills

  scope :finished, -> () {where(:completed => true).order(updated_at: :desc) }

  accepts_nested_attributes_for :skills

  # def skills_attributes=(skills_attributes)
  #   skills_attributes.values.each do |skill_attribute|
  #     skill = Skill.find_by(skill_attribute)
  #     self.skills << skill_attribute
  #   end
  # end

  # def self.finished
  #   where(completed: true).order(updated_at: :desc)
  # end



  def self.completed_today
    where(completed: true).where(updated_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(updated_at: :desc)
  end


  def self.incomplete
    where(completed: false).order(created_at: :desc)
  end


  def completion_time
    self.updated_at.strftime("%m/%d/%Y")
  end


  def self.last_five
    limit(5)
  end


  def duration
    created = self.created_at
    updated = self.updated_at
    minutes = (updated - created) / 1.minutes
    return minutes.round
  end

  # def self.tasks_that_are_not_yours
  #  Task.all.select { |task| task.user != current_user }
  # end

  
end
