class QuestSkill < ApplicationRecord
  belongs_to :quest
  belongs_to :skill
end
