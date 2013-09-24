require_relative "./cardfaces"

class Dealer
  include DataMapper::Resource, CardFaces
  property :id,        Serial
  property :deck,      Json
  belongs_to :blackjack_game, :required => false
  
  before :create, :set_deck
  
  def set_deck
    self.deck = CardDeck.receive
    shuffle
  end
  
  def shuffle
    self.deck.shuffle!
  end
  
  def deal(number_of_cards)
    dealt_cards = self.deck.shift(number_of_cards)
    self.save
    dealt_cards
  end
 
end
 
 
 