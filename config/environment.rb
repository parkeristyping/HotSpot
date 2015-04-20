require "bundler/setup"
require 'active_record'
require 'csv'
require 'yaml'
Bundler.require(:default, :development)

require_relative '../lib/population'
require_relative '../lib/location_analysis'

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)