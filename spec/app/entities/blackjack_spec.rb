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
      result = Blackjack.start(2).deal_down
      expect(result).to have(2).items
    end
    
    it "should distribute face up cards to players" do 
      result = Blackjack.start(2).deal_up
      expect(result).to have(2).items
    end
    
    it "should empty the array" do
      game = Blackjack.start(2)
      game.deal_up
      game.deal_down
      result = game.intial_cards
      expect(result).to have(0).items
    end
    
    it "should create a hand for player" do
      pending
    end
    
    it "should create a hand for house" do
      pending
    end
  end
  
  context "card value evaluation" do
  
    it "should strip away unneeded suit info" do
      pending
    end
  
    it "should assign number value for number cards" do
      pending
    end
    
    it "should assign value of 10 for face cards" do
      pending
    end
    
    it "should assign value of 1 or 10 for ace" do
      pending
    end
    
    it "should assing interger values to all cards" do
      pending
    end
  
  end
  
  context "game play" do
  
  
  end
  
end

  

