class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :user_id

      t.has_attached_file :file

      t.timestamps
    end
  end
end
