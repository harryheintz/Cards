require_relative '../spec_helper'
require_relative '../../../app/entities/card_deck'
require_relative '../../../app/entities/dealer'
require_relative '../../../app/entities/card_deck'
require_relative '../../../app/entities/user'
require_relative '../../../app/entities/house'
require_relative '../../../app/entities/artificial_player'
require_relative '../../../app/entities/blackjack_game'
require_relative '../../../app/entities/cardfaces'
require_relative '../../../app/entities/shared'




describe BlackjackGame do
  
  context "validation" do
    
    it "assigns an id" do
      attributes = { number_of_players: 2, user: User.create }
      result = BlackjackGame.start(attributes)
      expect(result.id).to eq 1
    end
  
    it "is false with nil number of players" do
      attributes = { number_of_players: nil, user: User.create }
      result = BlackjackGame.start(attributes)
      expect(result).to be nil
    end
    
  end
  
  context "initialization" do
    it "should return the correct number of players assigned" do
      attributes = { number_of_players: 2, user: User.create }
      result = BlackjackGame.start(attributes).number_of_players
      expect(result).to eq 2
    end
    
    it "should assign a dealer with a deck of cards" do
      attributes = { number_of_players: 2, user: User.create }
      result = BlackjackGame.start(attributes).dealer
      expect(result).not_to be_nil
    end
    
    it "should have a user" do
      attributes = { number_of_players: 2, user: User.create }
      result = BlackjackGame.start(attributes).user
      expect(result).not_to be_nil
    end
    
    it "should have a house" do
      attributes = { number_of_players: 2, user: User.create }
      result = BlackjackGame.start(attributes).house
      expect(result).not_to be_nil
    end
    
    it "should be able to create artificial players" do
      attributes = { number_of_players: 3, user: User.create }
      result = BlackjackGame.start(attributes).house
      expect(result).not_to be_nil
      
    end
  end
  
  context "initial card distribution" do
    
    it "should determine if artificial players are needed" do
      attributes = { number_of_players: 3, user: User.create }
      result = BlackjackGame.start(attributes).number_of_players - 2
      expect(result).to be > 0
    end
    
    it "should return the correct number of cards for dealing to all players" do
      attributes = { number_of_players: 2, user: User.create }
      result = BlackjackGame.start(attributes).number_of_cards_for_initial_deal
      expect(result).to eq 4
    end
    
    it "should assign down cards to user" do
      attributes = { number_of_players: 2, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.user.cards.hidden
      expect(result).to have(1).items
    end
    
    it "should assign up cards to user" do
      attributes = { number_of_players: 2, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.user.cards.visible
      expect(result).to have(1).items
    end
    
    it "should assign down cards to house" do
      attributes = { number_of_players: 2, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.house.cards.hidden
      expect(result).to have(1).items
    end
    
    it "should assign up cards to house" do
      attributes = { number_of_players: 2, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.house.cards.visible
      expect(result).to have(1).items
    end
    
    it "should assign down cards to artificial players" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.artificial_players.first.cards.hidden
      expect(result).to have(1).items
    end
    
    it "should assign up cards to artificial players" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.artificial_players.first.cards.visible
      expect(result).to have(1).items
    end
      
    it "should leave an empty array for initial cards" do
      attributes = { number_of_players: 2, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.initial_cards
      expect(result).to have(0).items      
    end
    
    it "should create a playing hand for the user" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.user.cards
      expect(result).to have(2).items
    end
    
    it "should create a playing hand for the house" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.house.cards
      expect(result).to have(2).items
    end
    
    it "should create a playing hand for the artificial player(s)" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.artificial_players.first.cards
      expect(result).to have(2).items
    end  
    
  end
  
  context "card value evaluation" do
  
    it "should strip away unneeded suit info" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.user.cards
      expect(result.each).not_to include(/Hearts,Clubs,Spades,Diamonds/)
    end
  
    it "should evaluate number value for number cards" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.user.cards.first.value
      expect(result).to be <= 11 #SHADY!!
      
    end
    
    it "should evaluate value of 1 or 11 for ace" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      new_hash =  { :name => "A", :value => 0}
      game.user.cards.update(new_hash)
      result = game.calculate_hand(game.user)
      expect(result).to eq(12)
    end
    
  end
  
  context "game play" do
    it "should retrieve cards from deal" do
      attributes = { number_of_players: 2, user: User.create }
      result = BlackjackGame.start(attributes).get_dealer_cards(1)
      expect(result.keys).to eq([:name, :suit])
    end
    
    it "should respond to hit option for user" do
      attributes = { number_of_players: 3, user: User.create }
      saved_game = BlackjackGame.start(attributes)
      options = {:id => saved_game.id, :hit => true, :stand => false, :split => false}
      result = BlackjackGame.play(options)
      expect(result.user.cards).to have(3).items
    end
    
    it "should know when to respond with stand option" do
      attributes = { number_of_players: 3, user: User.create }
      saved_game = BlackjackGame.start(attributes)
      options = {:id => saved_game.id, :hit => false, :stand => true, :split => false}
      result = BlackjackGame.play(options)
      expect(result.user.cards).to have(2).items
    end
    
    it "should know how to respond with split option" do
      pending
    end
    
    it "should evaluate Black Jack" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      total = 21
      result = game.evaluate_score(total)
      expect(result).to eq "Winner"
    end
    
    it "should know when player has won" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      total = 21
      result = game.evaluate_score(total)
      expect(result).to eq "Winner"
    end
    
    it "should know if the hand has busted" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      total = 22
      result = game.evaluate_score(total)
      expect(result).to eq "Defeat"
    end
    
    it "should know when house has won" do
      pending
    end
    
    it "should know when artificial player has won" do
      pending
    end
    
  end

  
end

  

