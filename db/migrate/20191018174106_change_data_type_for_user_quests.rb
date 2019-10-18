class ChangeDataTypeForUserQuests < ActiveRecord::Migration[6.0]
  def change
    change_table :user_quests do |t|
      t.change :completed, :boolean, default: false
    end
  end
end
