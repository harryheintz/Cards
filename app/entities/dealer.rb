class Dealer
  include DataMapper::Resource
  property :id,        Serial
  property :deck,      Json
  belongs_to :blackjack_game, :required => false
  
  before :create, :set_deck
  
  def set_deck
    @deck = CardDeck.receive
    shuffle
  end
  
  def shuffle
    @deck.shuffle!
  end
  
  def deal(number_of_cards)
    dealt_cards = @deck.shift(number_of_cards)
    @save
    dealt_cards
  end
 
end
 
 
 