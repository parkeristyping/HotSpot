class Post < ActiveRecord::Base

  belongs_to :user
  belongs_to :location

  def clean_text
    HTMLEntities.new.encode(text).delete("\n") if text
  end

end