class CreateUserTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_tasks do |t|
      t.string :notes
      t.boolean :completed, default: false
      t.belongs_to :user
      t.belongs_to :task

      t.timestamps
    end
  end
end
