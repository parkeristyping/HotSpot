require './config/environment'

class App < Sinatra::Base
  CALLBACK_URL = "http://localhost:9393/auth/instagram/callback"

  Instagram.configure do |config|
    config.client_id = "094bab4c239f462d9d009ded514f81c5"
    config.client_secret = "d03785a57a634d72b8168fcf05328e45"
  end

  get "/" do
    erb :splash
  end

  get "/auth/instagram/connect" do
    redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  end

  get "/auth/instagram/callback" do
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token
    redirect "/map"
  end

  get "/map" do
    @locations = Location.all
    erb :map
  end
end