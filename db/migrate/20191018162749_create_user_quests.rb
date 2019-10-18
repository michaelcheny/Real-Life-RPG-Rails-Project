class CreateUserQuests < ActiveRecord::Migration[6.0]
  def change
    create_table :user_quests do |t|
      t.integer :completed, default: false
      t.belongs_to :user
      t.belongs_to :quest

      t.timestamps
    end
  end
end
