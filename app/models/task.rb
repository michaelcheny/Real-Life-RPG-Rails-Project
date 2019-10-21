class Task < ApplicationRecord

  validates :name, presence: true, length: { minimum: 2 }
  validates :description, length: { maximum: 500 }
  validates :skills, presence: true
  validates :skills, length: { maximum: 3, message: "You can only train up to 3 skills per task." }

  
  belongs_to :user
  has_many :task_skills
  has_many :skills, through: :task_skills

  accepts_nested_attributes_for :skills

  scope :finished, -> () {where(:completed => true).order(updated_at: :desc) }

  # def self.finished
  #   where(completed: true).order(updated_at: :desc)
  # end

  # Grabs all the tasks done today
  def self.completed_today
    where(completed: true).where(updated_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(updated_at: :desc)
  end


  # Grabs all the incomplete tasks
  def self.incomplete
    where(completed: false).order(created_at: :desc)
  end


  # Shows the completion time for the task
  def completion_time
    self.updated_at.strftime("%m/%d/%Y")
  end


  # Grabs the last five tasks
  def self.last_five
    limit(5)
  end

  # Grabs the last three tasks
  def self.last_five
    limit(5)
  end



  # Gets duration of the task
  def duration
    created = self.created_at
    updated = self.updated_at
    minutes = (updated - created) / 1.minutes
    return minutes.round
  end

  
end
