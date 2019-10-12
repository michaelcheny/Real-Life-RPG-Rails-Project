class User < ApplicationRecord
  has_secure_password
  
  has_many :user_tasks
  has_many :tasks, through: :user_tasks
  has_many :user_skills
  has_many :skills, through: :user_skills

  accepts_nested_attributes_for :user_tasks

  

  ## validation for account creation
  # validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :username, presence: true, uniqueness: true, length: { minimum: 2}, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "cannot contain blank spaces or symbols" }
  validates :password_confirmation, presence: true, on: :create
  validates :password, presence: true, length: { in: 6..20 }, confirmation: true, unless: ->(u){ u.password.blank? }

end
