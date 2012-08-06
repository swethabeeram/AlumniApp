class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :hashed_password
      t.integer :course_id
      t.integer :year_of_passing

      t.timestamps
    end
  end
end
