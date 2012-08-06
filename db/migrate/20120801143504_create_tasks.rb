class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
