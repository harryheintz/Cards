module Implementation
  module API
    require "roar/representer/json"
    require "roar/representer/feature/hypermedia"
    
    module CardRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
      
      property :image_key
      property :value
      
    end
    
  end
end