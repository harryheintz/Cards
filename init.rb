require 'rubygems'
require 'sinatra/base'
require 'mustache/sinatra'
require 'haml'
require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'
require 'bundler/setup'
require 'pry'
require 'pry-doc'
require 'data_mapper'
require 'pg'
require 'dm-postgres-adapter'
require 'nesty'

# Bundler Setup.
Bundler.require(:default)

ENV['RACK_ENV'] = 'development'
config = YAML.load_file('config/database.yml')
DataMapper.setup(:default, config[ENV['RACK_ENV']])
DataMapper.finalize.auto_upgrade!

# Load all app files.
Dir["./app/**/*.rb"].each do |file|
 require file
end

# Load all implementation files.
Dir["./implementation/**/*.rb"].each do |file|
 require file
end