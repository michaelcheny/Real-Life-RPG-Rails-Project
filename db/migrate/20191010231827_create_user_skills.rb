class CreateUserSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :user_skills do |t|
      t.integer :level, default: 1
      t.integer :experience_pts, default: 0
      t.belongs_to :skill
      t.belongs_to :user

      t.timestamps
    end
  end
end
