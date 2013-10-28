module Implementation
  module API
    class V1 < Sinatra::Base
      set :public_folder, "./implementation/api/v1/public/"
      
      get '/' do
        "You need to request a specific endpoint."
      end
      
      put '/start' do
        # if game = BlackjackGame.start({user_id: 1, number_of_players: 3})
 #           game.to_json
 #        else
 #          status 404
 #        end
         attributes =  {number_of_players: 3, user_id: 1}.to_json
         game = BlackjackGame.start(attributes) 
         
      end
      
      post '/play' do
        "send some info back to the api"
      end
      
    end
  end
end