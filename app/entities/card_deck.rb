module CardFaces
  # modules always need to provide VALUES and SUITS constants
  VALUES = %w(2 3 4 5 6 7 8 9 10 J K Q A)
  SUITS = %w(Clubs Diamonds Hearts Spades)
end

class CardDeck
  include CardFaces
  attr_accessor :receive
  
  def receive
    build_deck
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
