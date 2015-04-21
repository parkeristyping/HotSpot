# ['<img src="http://www.w3schools.com/images/w3logotest2.png"><p>Caption here</p>', -33.890542, 151.274856, 4],
# ['Coogee Beach', -33.923036, 151.259052, 5],
# ['Cronulla Beach', -34.028249, 151.157507, 3],
# ['Manly Beach', -33.80010128657071, 151.28747820854187, 2],
# ['Maroubra Beach', -33.950198, 151.259302, 1]

class LocationList
  def self.create(locations)
    output = []
    locations.each {|location|
      row << "["
      location.posts.each_with_index {|post, index|
        row << "\'<div class=\"post-wrap\">"
        row << "<div class=\"post-thumb\"><img src=\"#{post.content_url}\"></div>"
        row << "<div class=\"post-caption\"><p>#{post.text}</p></div>"
        row << "</div>\'"
      }
      row << ", #{location.lat}, #{location.lng}, #{index}"
      row << "]"
      output << row
    }
    output.join(",")
  end
end