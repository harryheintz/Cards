class User
  include DataMapper::Resource
  property :id,               Serial
  property :hidden_cards,     Json
  property :visible_cards,    Json
  has n, :blackjack_games
end