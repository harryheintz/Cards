require_relative '../spec_helper'
require_relative '../../../app/entities/card_deck'

describe CardDeck do
 
  context "initilization" do
    
    it "values should not be an empty array" do
      result = CardDeck.new
      expect(result.values).not_to be_empty
    end
  
    it "suits should not be an empty array" do
      result = CardDeck.new
      expect(result.suits).not_to be_empty
    end
    
    it "cards should not by an empty array" do
      result = CardDeck.new
      expect(result.cards).not_to be_empty
    end
    
  end
  
end

  

