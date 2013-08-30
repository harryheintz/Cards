require_relative "./shared"
class House
  include DataMapper::Resource, Shared
  property :id,               Serial
  has n, :blackjack_games  
  has n, :cards
   
end