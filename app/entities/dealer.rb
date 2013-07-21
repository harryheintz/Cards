require_relative './card_deck'


class Dealer
  attr_accessor :cards
  
 def initialize(fresh_deck)
    @deck = fresh_deck
    
  end
  
  def shuffle
  end
  
  def split
  end
end
 #fresh_deck = CardDeck.new.cards