require_relative '../config/environment'

Instagram.configure do |config|
  config.client_id = "399548aa88ad4458ad3a0c347b07df06"
  config.client_secret = "46b4b03b33ea4a2f96fb2f24bc33ed83"
end

class Populate

  def self.users
    CSV.read('celebrities.csv').each {|celebrity|
      u = User.new
      u.instagram_username = celebrity.first
      u.instagram_id = Instagram.user_search(celebrity.first).first["id"]
      u.save
      print "."
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
        print "#{user.instagram_username} not public\n"
      end
    }
    print "\n"
  end

end