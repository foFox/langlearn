class CreateSessionTokens < ActiveRecord::Migration
  def change
    create_table :session_tokens do |t|      
      t.string :token_string, index: :true
      t.belongs_to :user, index: true      
      t.timestamps null: false
    end
  end
end
