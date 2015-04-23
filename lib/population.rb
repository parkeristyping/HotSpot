require_relative '../config/environment'

Instagram.configure do |config|
  config.client_id = "094bab4c239f462d9d009ded514f81c5"
  config.client_secret = "d03785a57a634d72b8168fcf05328e45"
end

class Populate

  def self.users
    CSV.read('celebrities.csv').each {|celebrity|
      begin
        u = User.new
        u.instagram_username = celebrity.first
        u.instagram_id = Instagram.user_search(celebrity.first).first["id"]
        u.save
        print "."
      rescue
        print "#{celebrity} not found\n"
      end
    }
    print "\n"
  end

  def self.posts
    User.all.each {|user|
      begin
        posts = Instagram.get("https://api.instagram.com/v1/users/" + user.instagram_id.to_s + "/media/recent")
        posts.each {|post|
          p = Post.new
          if post["images"]
            p.content_url = post["images"]["low_resolution"]["url"]
          end
          if post["caption"]
            p.text = post["caption"]["text"]
            p.created_time = post["caption"]["created_time"].to_i
          end
          if post["location"]
            if post["location"]["latitude"] && post["location"]["longitude"]
              p.lat = post["location"]["latitude"]
              p.lng = post["location"]["longitude"]
            end
            if post["location"]["name"]
              p.location_name = post["location"]["name"]
            end
          end
          p.user_id = user.id
          p.save
          print "*"
        }
        print "\n"
      rescue
        if user.instagram_username
          print "#{user.instagram_username} not public\n"
        else
          print "error"
        end
      end
    }
    print "\n"
  end

end