require_relative './card_deck'


class Dealer < CardDeck
  
  
  attr_accessor :cards
  
  
  def shuffle
    
  end
  
  def deal
    
  end
  
  
  
  
  deck = Dealer.new(CardDeck.new.cards)   
 
  
  
end
 