class UserSkill < ApplicationRecord
  belong_to :user
  belongs_to :skill
end
