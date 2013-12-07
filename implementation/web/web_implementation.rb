# Sinatra. Comes after the config.ru (Rack) Add more routes to load after the first "/" in the url.

module Implementation
  class Web < Sinatra::Base
    register Mustache::Sinatra
    require './implementation/web/views/web_view'

    set :mustache, {
      :views => 'implementation/web/views/',
      :templates => 'implementation/web/templates/'
    }
    
    set :public_folder, "implementation/web/public"
    
    get "/" do
      mustache :layout # Loads the layout file
    end
    
  end
end