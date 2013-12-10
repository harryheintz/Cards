# Sinatra. Comes after the config.ru (Rack) Add more routes to load after the first "/" in the url.

module Implementation
  class Web < Sinatra::Base
    register Mustache::Sinatra
    require './implementation/web/views/web_view'
    set :views, 'implementation/web/templates'
    set :public_folder, "implementation/web/public"
    
    # set :mustache, {
 #      :views => 'implementation/web/views/',
 #      :templates => 'implementation/web/templates/'
 #    }
    
    get "/" do
      erb :layout
    end
    
    # get "/home" do
#       mustache :home
#     end
#     
#     post "/start" do
#       mustache :start
#     end
#     
#     put "play" do
#       mustache :play
#     end
    
  end
end