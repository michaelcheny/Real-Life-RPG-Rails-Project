class CreateQuests < ActiveRecord::Migration[6.0]
  def change
    create_table :quests do |t|
      t.string :name
      t.string :description
      t.integer :difficulty_level
      t.integer :level_requirement

      t.timestamps
    end
  end
end
