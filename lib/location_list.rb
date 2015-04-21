require_relative '../config/environment'

class LocationList
  def self.create(locations)
    output = []
    locations.each_with_index {|location, index|
      row = "[\'<div><h3>#{location.clean_name}</h3></div>"
      location.posts.each {|post|
        row << "<div class=\"post-wrap\">"
        row << "<div class=\"post-thumb\"><img src=\"#{post.content_url}\"></div>"
        row << "<div class=\"user\"><p>#{post.user.instagram_username}</p></div>"
        row << "<div class=\"post-caption\"><p>#{post.clean_text}</p></div>"
        row << "</div>"
      }
      row << "\', #{location.lat.round(6)}, #{location.lng.round(6)}, #{index}"
      row << "]"
      output << row
      }
    "[" + output.join(",") + "]"
  end
end