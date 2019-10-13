class Task < ApplicationRecord
  has_many :user_tasks
  has_many :users, through: :user_tasks
  has_many :task_skills
  has_many :skills, through: :task_skills

  accepts_nested_attributes_for :users
end
