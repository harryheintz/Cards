require_relative './card_deck'

class Dealer
  attr_accessor :cards
  
  def initialize
    self.cards = CardDeck.new.cards
  end
 
end
 