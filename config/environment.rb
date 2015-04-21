require 'bundler/setup'
require 'active_record'
require 'csv'
require 'yaml'
Bundler.require(:default, :development)

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

require './app'

require_all './app/models'
require_all './lib'

#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
# configure :production, :development do
#   db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
 
#   ActiveRecord::Base.establish_connection(
#       :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
#       :host     => db.host,
#       :username => db.user,
#       :password => db.password,
#       :database => db.path[1..-1],
#       :encoding => 'utf8'
#   )
# end