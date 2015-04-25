class CreateCategories < ActiveRecord::Migration
  
  def change
    create_table :categories do |t|
      t.string :name
    end

    add_column :users, :category_id, :integer
    add_column :locations, :category_id, :integer
  end

end