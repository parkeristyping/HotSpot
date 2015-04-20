require_relative '../config/environment'

# Define a distance calculator
def distance loc1, loc2
  rad_per_deg = Math::PI/180  # PI / 180
  rkm = 6371                  # Earth radius in kilometers
  rm = rkm * 1000             # Radius in meters

  dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
  dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

  lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
  lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

  a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
  c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

  rm * c # Delta in meters
end

class Analyze
  @@google_client = GooglePlaces::Client.new("AIzaSyCjMO586R2fZZjzfrcOAIzhdZ4QgS9oFxk")
  @@threshold = 100
  @@extension = 5

  def self.locations
    # Lazy group posts within 50m
    Post.all.each {|post|
      if post.lat && !post.location_id
        # Check to see if there is a nearby location
        location_nearby = Location.all.any? {|location|
          (distance([post.lat, post.lng],[location.lat, location.lng]) < @@threshold)
        }

        if post.location_name
          text_match_location = Location.all.find {|location|
            words_in_location_name = post.location_name.split(" ")
            words_in_location_name.delete_if {|x| x.length < 5}
            text_match = words_in_location_name.any? {|word|
              location.name =~ /#{word}/i
            }
            text_match && (distance([post.lat, post.lng],[location.lat, location.lng]) < (@@threshold * @@extension))
          }
        end
        # If there is nearby location...
        if location_nearby || text_match_location
          if location_nearby
            # Find nearest location
            nearest_location = Location.all.min_by {|location|
              distance([post.lat, post.lng],[location.lat, location.lng])
            }
            # Update location 
            nearest_location.lat = (nearest_location.lat + post.lat) / 2.0
            nearest_location.lng = (nearest_location.lat + post.lat) / 2.0
            if post.location_name
              nearest_location.name = post.location_name
            end
          else
            nearest_location = text_match_location
          end      
          # add location ID to post
          post.location_id = nearest_location.id
          nearest_location.count += 1
          # save updates
          nearest_location.save
          post.save
          print "$"
        # If not, add new location
        else
          l = Location.new
          if post.location_name
            l.name = post.location_name
          else
            establishment = @@google_client.spots(post.lat, post.lng).find {|y| y.types.include? "establishment"}
            area = @@google_client.spots(post.lat, post.lng).first
            if establishment
              l.name = establishment.name
            else
              l.name = area.name
            end
          end
          l.lat = post.lat
          l.lng = post.lng
          l.count = 1
          l.save
          l = Location.find_by(lat: post.lat, lng: post.lng)
          post.location_id = l.id
          post.save
          print "#"
        end
      end
    }
    print "\n"
  end
end