# require "sinatra"
# require "instagram"

# enable :sessions

# CALLBACK_URL = "http://www.hereisahand.com"

# Instagram.configure do |config|
#   config.client_id = "399548aa88ad4458ad3a0c347b07df06"
#   config.client_secret = "46b4b03b33ea4a2f96fb2f24bc33ed83"
# end

# get "/" do
#   '
#     <div class="row">
#     <div class="large-3 columns">
#       <div style="width:400px; margin:0 auto;">
#       <h1><img src="http://placehold.it/400x100&text=HotSpot"></h1>
#     </div>
#     </div>

#   <div class="row">
#   <div class="large-3 columns">
#   <div style="width:150px; margin:0 auto;">  
#   <a href="/oauth/connect">Connect here with Instagram!</a>
#   </div>
#   </div>
#   '   
# end

# get "/oauth/connect" do
#   redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
# end

# get "/oauth/callback" do
#   response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
#   session[:access_token] = response.access_token
#   redirect "/dashboard"
# end

# get "/dashboard" do
#   client = Instagram.client(:access_token => session[:access_token])
#   user = client.user

#   html = "<h1>Posts for #{user.username}</h1>"

#   html
# end