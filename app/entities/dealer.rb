require_relative './card_deck'


class Dealer < CardDeck
  
  attr_accessor :cards
  
  
  
 def initialize(fresh_deck = Dealer.new(CardDeck.new.cards))
    
    deck = fresh_deck
    
  end
  
  
end
 