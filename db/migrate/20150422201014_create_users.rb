class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|    	
      t.timestamps null: false
      t.string :name
      t.string :surname
      t.string :email_address
      t.string :password_hash
      t.string :hash_salt
      t.column :user_type, "ENUM('student','tutor')"
    end
  end
end
