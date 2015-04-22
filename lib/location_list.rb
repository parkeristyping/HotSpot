require_relative '../config/environment'

class LocationList
  def self.create(locations)
    output = []
    locations.each_with_index {|location, index|
      row = "[\'<div class=\"loc-name pop-out\"><h2>"
      row << "<a href=\"#{location.url}\">" if location.url
      row << "#{location.clean_name}"
      row << "</a>" if location.url
      row << "</h2></div>"
      location.posts.each {|post|
        row << "<div class=\"post-wrap pop-out\">"
        row << "<div class=\"post-thumb pop-out\"><img src=\"#{post.content_url}\"></div>"
        row << "<div class=\"user pop-out\"><p>#{post.user.instagram_username}</p></div>"
        row << "<div class=\"post-caption pop-out\"><p>#{post.clean_text}</p></div>"
        row << "</div>"
      }
      row << "\', #{location.lat.round(6)}, #{location.lng.round(6)}, #{index}"
      row << "]"
      output << row
      }
    "[" + output.join(",") + "]"
  end
end