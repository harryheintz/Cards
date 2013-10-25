require 'data_mapper'
require 'pg'
require 'dm-postgres-adapter'
require 'rspec'
require 'dm-rspec'
require 'rack/test'

# Load all app files.
Dir["./app/**/*.rb"].each do |file|
 require file
end

ENV['RACK_ENV'] = 'test'
config = YAML.load_file('config/database.yml')
DataMapper.setup(:default, config[ENV['RACK_ENV']])
DataMapper.finalize.auto_upgrade!

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include DataMapper::Matchers
  conf.before(:each) { DataMapper.auto_migrate! }
end