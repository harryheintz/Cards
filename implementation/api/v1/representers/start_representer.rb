module Implementation
  module API
    require "roar/representer/json"
    require "roar/representer/feature/hypermedia"
    
    module StartRequestRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
      
      property :user_id
      property :number_of_players
      
    end
    
    module StartResponseRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
      
    end
    
  end
end