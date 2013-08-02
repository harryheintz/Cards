class Dealer
  attr_accessor :deck
  
  def initialize
    self.deck = CardDeck.new.receive
    shuffle
  end
  
  def shuffle
    deck.shuffle!
  end
  
  def deal(number_of_cards)
    deck.shift(number_of_cards)
  end
 
end
 
 
 