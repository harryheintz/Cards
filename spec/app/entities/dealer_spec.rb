require_relative '../spec_helper'
require_relative '../../../app/entities/dealer'
require_relative '../../../app/entities/card_deck'

describe Dealer do
 
  context "initilization" do
    
    it "should have a fresh deck of cards" do
      result = Dealer.new
      expect(result.cards).not_to be_empty
    end
    
  end
  
end

  

