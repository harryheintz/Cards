class ArtificialPlayer
  include DataMapper::Resource
  property :id,               Serial
  property :hidden_cards,     Json
  property :visible_cards,    Json
  belongs_to :blackjack_game, :required => false
end