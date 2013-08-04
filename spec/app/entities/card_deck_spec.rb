require_relative '../spec_helper'
require_relative '../../../app/entities/card_deck'

describe CardDeck do
 
  context "initilization" do
    
    it "get should not be an empty array" do
      result = CardDeck.receive
      expect(result).not_to be_empty
    end
    
  end
  
end

  

