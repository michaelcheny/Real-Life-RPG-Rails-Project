class User < ApplicationRecord
  has_secure_password
  
  has_many :tasks
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :user_quests
  has_many :quests, through: :user_quests

  accepts_nested_attributes_for :tasks

  ## validation for account creation
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :username, presence: true, uniqueness: true, length: { minimum: 2}, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "cannot contain blank spaces or symbols" }
  validates :password_confirmation, presence: true, on: :create
  validates :password, presence: true, length: { in: 6..20 }, confirmation: true, unless: ->(u){ u.password.blank? }


  def self.from_omniauth(auth)
    # Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_initialize do |user|
      user.username = auth.info.name.split(" ").first + rand(1..100).to_s
      user.email = auth.info.email
      random_password = RandomPasswordGenerator.generate(18)
      user.password = random_password
      user.password_confirmation = random_password
    end
  end


  # Calculates the users total exp
  def total_exp_pts
    total_exp = 0 
    self.user_skills.each do |user_skill|
      total_exp += user_skill.experience_pts
    end
    return total_exp
  end


  # Caculates their total level
  def total_level
    total_level = 0
    self.user_skills.each do |user_skill|
      total_level += user_skill.level
    end
    return total_level
  end


  # Grabs all the completed quests.
  def sort_quests_by_completed
    self.user_quests.where(completed: true).order(updated_at: :desc)
  end

   # Grabs all the incompleted quests.
   def sort_quests_by_incomplete
    self.user_quests.where(completed: false).order(created_at: :asc)
  end



  # Grabs the completed quests for today
  def quests_completed_today
    self.user_quests.where(completed: true).where(updated_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(updated_at: :desc)
  end



  

end
