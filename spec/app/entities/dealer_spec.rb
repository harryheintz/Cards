require_relative '../spec_helper'
require_relative '../../../app/entities/dealer'
require_relative '../../../app/entities/card_deck'

describe Dealer do
 
  context "initilization" do
    
    it "should have a fresh deck of cards" do
      result = Dealer.new(CardDeck.new.cards)
      expect(result).not_to be_nil
    end
    
    it "should have the correct number of cards" do
      result = deck
      expect(result.count).to eq 52
    end
    
      
    
  end
  
end

  

