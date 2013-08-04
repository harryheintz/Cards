require_relative '../spec_helper'
require_relative '../../../app/entities/dealer'
require_relative '../../../app/entities/card_deck'
require_relative '../../../app/entities/blackjack'

describe Blackjack do
  
  context "initialization" do
    it "should return the correct number of players assigned" do
      result = Blackjack.start(1).number_of_players
      expect(result).to eq 1
    end
    
    it "should assign a dealer with a deck of cards" do
      result = Blackjack.start(1).dealer
      expect(result).not_to be_nil
    end
  end
  context "initial card distribution" do
    
    it "should return the correct number of cards for dealing to all players" do
      result = Blackjack.start(2).number_of_cards_for_inital_deal
      expect(result).to eq 4
    end
    
    it "should receive cards from dealer" do
      result = Blackjack.start(2).cards_for_first_deal
      expect(result).to have(4).items
    end
    
    it "should distribute face down cards to players" do 
      pending
    end
    
    it "should distribute face up cards to players" do 
      pending
    end
  end
  
end

  

