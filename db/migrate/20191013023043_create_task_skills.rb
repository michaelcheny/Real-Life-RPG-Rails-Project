class CreateTaskSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :task_skills do |t|
      t.integer :points
      t.belongs_to :task
      t.belongs_to :skill
      
      t.timestamps
    end
  end
end
