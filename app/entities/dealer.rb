require_relative './card_deck'


class Dealer < CardDeck
  
  
  attr_accessor :cards
  
  def initialize(fresh_deck)
    
    @deck = fresh_deck
    
  end
  
  
  
  
  
  
  fresh_deck = CardDeck.new.cards  
 
  
  
end
 