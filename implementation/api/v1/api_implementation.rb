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
        if response = BlackjackGame.start(body)
           status 201
           response.to_json
        else
          status 404
        end
      end
      
      put '/play' do
        body = JSON.parse(request.body.read)
        if response = BlackjackGame.play(body)
           status 200
           response.to_json
        else
          status 404
        end
      end
      
      # post '/login' do
 #         body = JSON.parse(request.body.read)
 #         if response
      
    end
  end
end