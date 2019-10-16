class User < ApplicationRecord
  has_secure_password
  
 
  has_many :tasks
  has_many :user_skills
  has_many :skills, through: :user_skills

  accepts_nested_attributes_for :tasks

  

  ## validation for account creation
  # validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :username, presence: true, uniqueness: true, length: { minimum: 2}, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "cannot contain blank spaces or symbols" }
  validates :password_confirmation, presence: true, on: :create
  validates :password, presence: true, length: { in: 6..20 }, confirmation: true, unless: ->(u){ u.password.blank? }


  def self.from_omniauth(auth)
    # Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.username = auth.info.name.split(" ").first
      user.email = auth.info.email
      random_password = RandomPasswordGenerator.generate(18)
      user.password = random_password
      user.password_confirmation = random_password
    end
  end


  def total_exp_pts
    total_exp = 0 
    self.user_skills.each do |user_skill|
      total_exp += user_skill.experience_pts
    end
    return total_exp
  end

  # def self.sort_by_total_exp
  #   where(total_exp_pts: :desc)
  # end

  # def sort_by_total_exp
  #   sort_by{|u| u.total_exp_pts}.reverse
  # end


end
