class UserTask < ApplicationRecord
  belongs_to :user, inverse_of: :user_tasks
  belongs_to :task, inverse_of: :user_tasks

  accepts_nested_attributes_for :task
end
