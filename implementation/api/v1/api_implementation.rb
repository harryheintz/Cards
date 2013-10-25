module Implementation
  module API
    class V1 < Sinatra::Base
      set :public_folder, "./implementation/api/v1/public/"
      
      get '/' do
        "You need to request a specific endpoint."
      end
      
      post '/start' do
        if game = BlackjackGame.start({user_id: params[:user_id], number_of_players: params[:number_of_players]})
          game.to_json
        else
          status 404
        end
      end
      
    end
  end
end