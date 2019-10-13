class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.integer :difficulty_level
      t.integer :priority_level
      t.belongs_to :user

      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
