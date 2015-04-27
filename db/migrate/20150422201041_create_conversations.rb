class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.timestamps null: false
      t.integer :student_id 
      t.integer :tutor_id
      t.column :state, "ENUM('new','declined','open','closed')"
      t.integer :language_id
    end
  end
end
