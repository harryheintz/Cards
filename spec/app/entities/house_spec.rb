require_relative '../spec_helper'
require_relative '../../../app/entities/artificial_player'
require_relative '../../../app/entities/blackjack_game'
require_relative '../../../app/entities/user'
require_relative '../../../app/entities/dealer'
require_relative '../../../app/entities/card_deck'
require_relative '../../../app/entities/house'
require_relative '../../../app/entities/cardfaces'



describe House do
 
  context "validation" do
  
    it "assigns an id" do
      result = House.create
      expect(result.id).to eq 1
    end
  
  end
  
  context "playing a card game" do
    
    it "should hold hidden cards" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.house.cards.first.hidden
      expect(result).to be_true 
    end
    
    it "should hold visible cards" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.house.cards.last.hidden
      expect(result).to be_false 
    end
    
  end
  
  context "playing Blackjack" do
    
    it "should know when to respond with hit option" do
      pending
    end
    
    it "should know when to respond with stand option" do
      pending
    end
    
    it "should know how to respond with split option" do
      pending
    end
    
  end
end
