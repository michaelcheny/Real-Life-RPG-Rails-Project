class CreateQuestSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :quest_skills do |t|
      t.integer :points
      t.belongs_to :quest
      t.belongs_to :skill

      t.timestamps
    end
  end
end
