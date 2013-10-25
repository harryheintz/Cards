require_relative '../spec_helper'

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
    
    it "should save deck" do
      deck = CardDeck.receive
      Dealer.create
      result = Dealer.get(1)
      expect(result.deck).not_to be_nil
    end
  end
  
  context "the dealer" do
    
    it "should deal the appropriate number of cards" do
      result = Dealer.create
      expect(result.deal(2).count).to eq 2
    end
    
    
  end
end

  

