module Implementation
  class Web < Sinatra::Base
    register Mustache::Sinatra
    require './implementation/web/views/web_view'

    set :mustache, {
      :views => 'implementation/web/views/',
      :templates => 'implementation/web/templates/'
    }
    
    set :public_folder, "implementation/web/public/"
    
    get "/" do
      mustache :home
    end
    
    get "/test" do
      @game = BlackjackGame.start({ "number_of_players" => 3, "user_id" => 1 }).to_json
      mustache :test
    end
    
  end
end