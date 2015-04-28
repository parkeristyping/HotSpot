# Google Places re-done
require 'httparty'  
class GooglePlacesAPI
  #...define search URLs like NEARBY_SEARCH_URL...
  #...initialize client with API key...

  def nearby_search(lat, lng, name)
    options = {location_component: "location=#{lat},#{lng}",
               name_component: "name=#{name}",...}
    search = NEARBY_SEARCH_URL + prepare(options)
    HTTParty::get(search)["results"].first # return first result
  end

  #...'get_url' method...
  #...helper methods like 'prepare'...
end  