class CreateUsersAndLanguages < ActiveRecord::Migration
  def change
    create_table :languages_users do |t|
    	t.belongs_to :user, index:true
    	t.belongs_to :language, index:true 
    end
  end
end
