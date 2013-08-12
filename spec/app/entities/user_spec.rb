require_relative '../spec_helper'
require_relative '../../../app/entities/user'

describe User do
 
  context "validation" do
  
    it "has an id" do
      result = User.new
      result.save
      expect(result.id).to eq 1
    end
  
  end
  
  context "playing a card game" do
    
    it "should hold hidden cards" do
      attributes = { hidden_cards: ["AClubs", "9Diamonds"]}
      result = User.new(attributes)
      result.save
      expect(result.hidden_cards).to match_array(["AClubs", "9Diamonds"])
    end
    
    it "should hold visible cards" do
      attributes = { visible_cards: ["2Hearts", "JClubs"]}
      result = User.new(attributes)
      result.save
      expect(result.hidden_cards).to match_array(["2Hearts", "JClubs"])
      
    end
    
  end
end
