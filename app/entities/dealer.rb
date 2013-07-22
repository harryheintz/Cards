require_relative './card_deck'

class Dealer
  attr_accessor :cards, :fresh_deck
  
  def initialize
    self.fresh_deck = CardDeck.new.cards
  end
  
  def shuffle
    fresh_deck.shuffle!
    
  end
  
  def deal
    
  end
  
  

 
end
 