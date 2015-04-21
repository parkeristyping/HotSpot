require_relative 'config/environment'

class App < Sinatra::Base
  get '/' do
    @locations = Location.all
    erb :locations
  end
end