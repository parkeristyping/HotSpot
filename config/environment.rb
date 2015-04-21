require "bundler/setup"
require 'active_record'
require 'csv'
require 'yaml'
Bundler.require(:default, :development)

require './app'

require_all 'models'
require_all 'lib'

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)