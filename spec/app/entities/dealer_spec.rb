require_relative '../spec_helper'
require_relative '../../../app/entities/dealer'
require_relative '../../../app/entities/card_deck'

describe Dealer do
 
  context "initilization" do
  
    it "should have a deck of cards" do
      result = Dealer.new
      expect(result.deck).not_to be_empty
    end
  
    it "should be shuffled" do
      deck = CardDeck.receive
      result = Dealer.new
      expect(result.deck).not_to eq(deck)
    end
    
  end
  
  context "the dealer" do
    
    it "should deal the appropriate number of cards" do
      result = Dealer.new
      expect(result.deal(2).count).to eq 2
    end
    
    it "should deal the appropriate number of cards" do
      result = Dealer.new
      dealt_cards = result.deal(3)
      expect(result.deck).to_not include(dealt_cards[0], dealt_cards[1])
    end
    
  end
end

  

