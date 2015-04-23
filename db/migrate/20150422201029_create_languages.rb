class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.timestamps null: false
      t.string :name      
    end
  end
end
