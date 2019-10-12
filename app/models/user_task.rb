class UserTask < ApplicationRecord
  belongs_to :user
  belongs_to :task

  # accepts_nested_attributes_for :tasks
end
