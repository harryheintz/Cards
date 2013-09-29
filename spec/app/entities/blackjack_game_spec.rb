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
      result = game.user.calculate_hand
      expect(result).to eq(12)
    end
    
  end
  
  context "game play" do
    it "should retrieve cards from deal" do
      attributes = { number_of_players: 2, user: User.create }
      result = BlackjackGame.start(attributes).get_dealer_cards(1)
      expect(result.keys).to eq([:name, :suit])
    end
    
    it "should know when to respond with the hit option" do
      pending
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
  end  
    
  context "individual hand evaluation" do 
    
    it "should know when there is a push" do
      attributes = { number_of_players: 3 , user: User.create }
      game = BlackjackGame.start(attributes)
      game.hit(game.user)
      game.user.cards.fetch(0).update(:value=>10)
      game.user.cards.fetch(1).update(:value=>9)
      game.user.cards.fetch(2).update(:value=>2)
      game.user.cards.update(:name=>"test")
      game.hit(game.house)
      game.house.cards.fetch(0).update(:value=>10)
      game.house.cards.fetch(1).update(:value=>9)
      game.house.cards.fetch(2).update(:value=>2)
      game.house.cards.update(:name=>"test")
      # game.hit(game.artificial_players.first)
#       game.artificial_players.first.cards.fetch(0).update(:value=>10)
#       game.artificial_players.first.cards.fetch(1).update(:value=>9)
#       game.artificial_players.first.cards.fetch(2).update(:value=>1)
#       game.artificial_players.first.cards.update(:name=>"test")
      result = game.is_push?
      expect(result).to be_true
    end
    
    it "should know when there is a winner due to twenty one" do
      attributes = { number_of_players: 2, user: User.create }
      game = BlackjackGame.start(attributes)
      game.hit(game.user)
      game.user.cards.fetch(0).update(:value=>10)
      game.user.cards.fetch(1).update(:value=>9)
      game.user.cards.fetch(2).update(:value=>1)
      game.user.cards.update(:name=>"test")
      game.hit(game.house)
      game.house.cards.fetch(0).update(:value=>10)
      game.house.cards.fetch(1).update(:value=>9)
      game.house.cards.fetch(2).update(:value=>2)
      game.house.cards.update(:name=>"test")
      result = game.is_winner?
      expect(result).to be_true 
     
    end
    
    it "should know when the game ends due to card exhaustion" do
      pending
      #attributes = { number_of_players: 3, user: User.create }
      #game = BlackjackGame.start(attributes)
      
    end
    
  end
  
  context "game status" do  
    it "should know if the house busts, the game is over" do
        attributes = { number_of_players: 3, user: User.create }
        game = BlackjackGame.start(attributes)
        game.hit(game.house)
        game.house.cards.fetch(0).update(:value=>10)
        game.house.cards.fetch(1).update(:value=>10)
        game.house.cards.fetch(2).update(:value=>10)
        game.house.cards.update(:name=>"test")
        result = game.game_over?
        expect(result).to be_true
    end
      
    it "should know if there is a Blackjack from any player, the game is over" do
        attributes = { number_of_players: 2, user: User.create }
        game = BlackjackGame.start(attributes)
        game.user.cards.fetch(0).update(:value=>10)
        game.user.cards.fetch(1).update(:value=>11)
        game.user.cards.update(:name=>"test")
        game.house.cards.fetch(0).update(:value=>10)
        game.house.cards.fetch(1).update(:value=>9)
        game.house.cards.update(:name=>"test")
        result = game.game_over?
        expect(result).to be_true 
    end
    
    it "should know if any player reaches 21, the game is over" do
        attributes = { number_of_players: 2, user: User.create }
        game = BlackjackGame.start(attributes)
        game.hit(game.user)
        game.user.cards.fetch(0).update(:value=>10)
        game.user.cards.fetch(1).update(:value=>9)
        game.user.cards.fetch(2).update(:value=>1)
        game.user.cards.update(:name=>"test")
        game.hit(game.house)
        game.house.cards.fetch(0).update(:value=>10)
        game.house.cards.fetch(1).update(:value=>9)
        game.house.cards.fetch(2).update(:value=>2)
        game.house.cards.update(:name=>"test")
        result = game.game_over?
        expect(result).to be_true 
    end
    
    it "should know if any two or more players push, the game is over" do
        attributes = { number_of_players: 3 , user: User.create }
        game = BlackjackGame.start(attributes)
        game.hit(game.user)
        game.user.cards.fetch(0).update(:value=>10)
        game.user.cards.fetch(1).update(:value=>9)
        game.user.cards.fetch(2).update(:value=>2)
        game.user.cards.update(:name=>"test")
        game.hit(game.house)
        game.house.cards.fetch(0).update(:value=>10)
        game.house.cards.fetch(1).update(:value=>9)
        game.house.cards.fetch(2).update(:value=>2)
        game.house.cards.update(:name=>"test")
        game.hit(game.artificial_players.first)
        game.artificial_players.first.cards.fetch(0).update(:value=>10)
        game.artificial_players.first.cards.fetch(1).update(:value=>9)
        game.artificial_players.first.cards.fetch(2).update(:value=>2)
        game.artificial_players.first.cards.update(:name=>"test")
        result = game.game_over?
        expect(result).to be_true
    end
    
  end
  
end

  

