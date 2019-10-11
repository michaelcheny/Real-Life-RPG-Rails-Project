class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  scope :top_skill_by_user, -> (u) {where(user_id: u.id).order_by("level").limit("1") }



end
