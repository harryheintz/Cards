class Blackjack
  
  attr_accessor :number_of_players, :player, :number_of_cards
  
  def initialize(individuals)
    self.player = individuals
    
  end
  
  def number_of_players
    self.player
    
  end
  
  def hand
    number_of_cards = (number_of_players * 2)
    
  end
 
  
end