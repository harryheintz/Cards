require_relative "./shared"
class User
  include DataMapper::Resource, Shared
  property :id,               Serial
  property :hidden_cards,     Json
  property :visible_cards,    Json
  has n, :blackjack_games  
  
end