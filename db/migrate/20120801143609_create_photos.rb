class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id

      t.has_attached_file :photo

      t.integer :event_id

      t.timestamps
    end
  end
end
