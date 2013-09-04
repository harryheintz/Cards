require_relative '../spec_helper'
require_relative '../../../app/entities/artificial_player'
require_relative '../../../app/entities/blackjack_game'
require_relative '../../../app/entities/user'
require_relative '../../../app/entities/dealer'
require_relative '../../../app/entities/card_deck'
require_relative '../../../app/entities/house'


describe Dealer do
  
  context "validation" do
  
    it "assigns an id" do
      result = Dealer.create
      expect(result.id).to eq 1
    end
  
  end
 
  context "initilization" do
  
    it "should have a deck of cards" do
      result = Dealer.create
      expect(result.deck).not_to be_empty
    end
  
    it "should be shuffled" do
      deck = CardDeck.receive
      result = Dealer.create
      expect(result.deck).not_to eq(deck)
    end
    
  end
  
  context "the dealer" do
    
    it "should deal the appropriate number of cards" do
      result = Dealer.create
      expect(result.deal(2).count).to eq 2
    end
    
    
  end
end

  

