require 'bundler/setup'
Bundler.require(:default, :development)
require 'active_record'
require 'yaml'
require 'csv'
require 'wikipedia'
require 'shotgun'

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

# Configure Instagram API
Instagram.configure do |config|
  config.client_id = "094bab4c239f462d9d009ded514f81c5"
  config.client_secret = "d03785a57a634d72b8168fcf05328e45"
end

require_all './lib'
require_all './app/models'
require './app'