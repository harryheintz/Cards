# Rack stuff. Sets the "Route" after the ".com" 

require './init'

map "/" do
 run Implementation::Web
end

map '/api/v1' do
  run Implementation::API::V1
end

# map "/game/" do
#  run Implementation::Ember
# end
# 
# map "/mobile/" do
#  run Implementation::Mobile
# end