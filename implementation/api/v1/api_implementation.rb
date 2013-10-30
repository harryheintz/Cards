module Implementation
  module API
    class V1 < Sinatra::Base
      require 'json'
      
      set :public_folder, "./implementation/api/v1/public/"
      
      before do
        headers 'Content-Type' => "application/json;charset=utf-8",
                'Accept' => 'application/json'
      end
      
      get '/' do
        "You need to request a specific endpoint."
      end
      
      post '/start' do
        body = JSON.parse(request.body.read)
        if game = BlackjackGame.start(body)
           status 201
           "Your game id is: #{game.id}"
        else
          status 404
        end
      end
      
      put '/play' do
        "send some info back to the api"
      end
      
    end
  end
end