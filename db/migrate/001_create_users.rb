class CreateUsers < ActiveRecord::Migration
  
  def change
    create_table :users do |t|
      t.string :instagram_username
      t.integer :instagram_id
    end
  end

end