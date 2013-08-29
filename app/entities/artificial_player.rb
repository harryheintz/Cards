require_relative "./shared"

class ArtificialPlayer
  include DataMapper::Resource, Shared
  property :id,               Serial
  property :hidden_cards,     Json
  property :visible_cards,    Json
  belongs_to :blackjack_game, :required => false
  
   attr_accessor :stripped
  
end