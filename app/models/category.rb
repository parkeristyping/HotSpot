class Category < ActiveRecord::Base
  attr_accessor :instagram_usernames

  has_many :users
  has_many :posts, through: :users
  has_many :locations

  def self.create
    Dir.glob('./categories/*.csv') do |f|
      name = File.basename(f)
      name = name[6..name.size-5]
      category = new(:name => name)
      CSV.read(f).each {|array|
        category.instagram_usernames << array.first
      }
      # Eliminate duplicates
      category.instagram_usernames.uniq!
      # For each username
      category.instagram_usernames.each {|username|
        begin
          user = Instagram.user_search(username).first
          User.add_or_update(user, nil, self)
        rescue
          puts "User not found"
        end
      }
    end
  end

  def create_locations
    Location.create_for_category(self)
  end

end