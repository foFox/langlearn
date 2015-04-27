class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.timestamps null: false      
      t.belongs_to :user, index: true
      t.belongs_to :conversation, index: true
      t.string :text
    end
  end
end
