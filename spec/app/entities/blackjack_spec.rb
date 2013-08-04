require_relative '../spec_helper'
require_relative '../../../app/entities/dealer'
require_relative '../../../app/entities/card_deck'
require_relative '../../../app/entities/blackjack'

describe Blackjack do
  
  context "initialization" do
    it "should return a number of players" do
      result = Blackjack.new(1).number_of_players
      expect(result).to be > 0 
    end
    
  end
  context "card distribution" do
    
    it "should return the correct number of card for the hand" do
      result = Blackjack.new(2).starting_hand
      result_2 = Blackjack.new(2).number_of_players
      expect(result / result_2).to equal 2
    end
  end
  
  
end

  

