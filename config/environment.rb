require 'bundler/setup'
Bundler.require(:default, :development)
require 'active_record'
require 'yaml'
require 'csv'

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

require './app'
require_all './app/models'
require_all './lib'