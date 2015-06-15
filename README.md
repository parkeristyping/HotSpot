# HotSpot

Hotspot is a site that displays the locations of recent Instagram posts on a map. It was built at the Flatiron School by Parker Lawrence and Findlay Parke.

## Usage
Upon visiting Hotspot, users are given two options:
- Log in to Instagram to see the Instagram posts of people you follow
- Choose a pre-set default group of well-known Instagram users with public profiles (e.g. there is a 'food' category with chefs and food bloggers)

The app uses the Instagram API to find recent location-enabled posts by the selected user group. It then uses the name and location data to query the Google Places API to find a corresponding website for the location. Using this data, HotSpot populates a map created with the Google Maps JavaScript API. Users can click on points on the map to view the post(s) associated with that location, and locations with posts from more than one unique user are given a different icon to denote them as "hot spots".

The server was built using the Sinatra framework in Ruby.
