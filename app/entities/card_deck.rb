
require_relative "./cardfaces"

class CardDeck
  include CardFaces
  
  def self.receive
    deck = self.new
    deck.build_deck
  end
  
  def build_deck
    deck_array = []
    
    SUITS.each do |suit|
      VALUES.each do |value|
        card = value + suit
        deck_array << card
      end
    end
    
    deck_array
  end
  
end
