require './init'

map "/" do
 run Implementation::Web
end

map '/api/v1' do
  run Implementation::API::V1
end