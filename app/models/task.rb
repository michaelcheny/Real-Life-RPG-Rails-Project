class Task < ApplicationRecord
 
  belongs_to :user
  has_many :task_skills
  has_many :skills, through: :task_skills



  
end
