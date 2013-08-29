require_relative "./shared"
class House
  include DataMapper::Resource, Shared
  property :id,               Serial #house.id
  property :hidden_cards,     Json
  property :visible_cards,    Json  
  belongs_to :blackjack_game, :required => false #house.blackjack_game_id
  
  
end