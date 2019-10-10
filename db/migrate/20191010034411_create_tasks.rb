class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.integer :difficulty_level
      t.integer :priority_level

      t.timestamps
    end
  end
end
