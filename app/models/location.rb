class Location < ActiveRecord::Base

  has_many :posts
  has_many :users, through: :posts

  def clean_name
    HTMLEntities.new.encode(name).delete("\n") if name
  end

end