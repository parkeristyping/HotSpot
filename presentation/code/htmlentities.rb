# Cleaning for URL insertion
require 'htmlentities'  
ENCODER = HTMLEntities.new  
options = {location_component: "location=#{lat},#{lng}",  
               name_component: "name=#{ENCODER.encode(name, :named)}",
               ...}

# Here's an example of how it works...
ENCODER.encode("root & bone", :named) #=> "root &amp; bone"