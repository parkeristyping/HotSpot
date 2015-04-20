class CreatePosts < ActiveRecord::Migration
  
  def change
    create_table :posts do |t|
      t.text :content_url
      t.text :text
      t.float :lat
      t.float :lng
      t.string :location_name
      t.integer :created_time
    end
  end

end