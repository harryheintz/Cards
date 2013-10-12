require_relative '../spec_helper'
require_relative '../../../app/entities/artificial_player'
require_relative '../../../app/entities/blackjack_game'
require_relative '../../../app/entities/user'
require_relative '../../../app/entities/dealer'
require_relative '../../../app/entities/card_deck'
require_relative '../../../app/entities/house'
require_relative '../../../app/entities/cardfaces'



describe User do
 
  context "validation" do
  
    it "assigns an id" do
      result = User.create
      expect(result.id).to eq 1
    end
  
  end
  
  context "verifying a card hand" do
    
    it "should hold hidden cards" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.user.cards.first.hidden
      expect(result).to be_true 
    end
    
    
    it "should hold visible cards" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      result = game.user.cards.last.hidden
      expect(result).to be_false 
    end
  end
    
  context "game play" do
      
      it "should respond to a hit request" do
        attributes = { number_of_players: 3, user: User.create }
        saved_game = BlackjackGame.start(attributes)
        options = {:id => saved_game.id, :hit => true, :stand => false, :split => false}
        result = BlackjackGame.play(options)
        expect(result.user.cards).to have(3).items
      end
      
      it "should respond to a stand request" do
        attributes = { number_of_players: 3, user: User.create }
        saved_game = BlackjackGame.start(attributes)
        options = {:id => saved_game.id, :hit => false, :stand => true, :split => false}
        result = BlackjackGame.play(options)
        expect(result.user.cards).to have(2).items
      end
      
      it "should determine if a hand is eleigble for a split" do
        attributes = { number_of_players: 3, user: User.create }
        game = BlackjackGame.start(attributes)
        game.user.cards.fetch(0).update(:value=>10)
        game.user.cards.fetch(1).update(:value=>10)
        game.user.cards.update(:name=>"test")
        result = game.user.can_split?
        expect(result).to be_true
      end
      
      it "should respond with a split request" do
        attributes = { number_of_players: 3, user: User.create }
        saved_game = BlackjackGame.start(attributes)
        saved_game.user.cards.fetch(0).update(:value=>10)
        saved_game.user.cards.fetch(1).update(:value=>10)
        saved_game.user.cards.update(:name=>"test")
        options = {:id => saved_game.id, :hit => false, :stand => false, :split => true}
        game = BlackjackGame.play(options)
        result = game.user.split_cards
        expect(result).to have(2).items
      end
      
      it "should hold split cards" do
        attributes = { number_of_players: 3, user: User.create }
        saved_game = BlackjackGame.start(attributes)
        saved_game.user.cards.fetch(0).update(:value=>10)
        saved_game.user.cards.fetch(1).update(:value=>10)
        saved_game.user.cards.update(:name=>"test")
        options = {:id => saved_game.id, :hit => false, :stand => false, :split => true}
        game = BlackjackGame.play(options)
        result = game.user.cards.last
        expect(result.split_card).to be_true
      end
  end
  
  context "hand calculation" do
    
    it "should evaluate hand for Black Jack" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      hash_one = {:value => 10}
      hash_two = {:value => 11}
      new_hash = {:name => "test"}
      game.user.cards.update(new_hash)
      game.user.cards.first.update(hash_one)
      game.user.cards.last.update(hash_two)
      result = game.user.blackjack?
      expect(result).to be_true
    end


    it "should evaluate hand for twenty one" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      game.hit(game.user)
      game.user.cards.fetch(0).update(:value=>10)
      game.user.cards.fetch(1).update(:value=>10)
      game.user.cards.fetch(2).update(:value=>1)
      game.user.cards.update(:name=>"test")
      result = game.user.twenty_one?
      expect(result).to be_true
    end

    it "should evaluate hand for busted" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      game.hit(game.user)
      game.user.cards.fetch(0).update(:value=>10)
      game.user.cards.fetch(1).update(:value=>10)
      game.user.cards.fetch(2).update(:value=>10)
      game.user.cards.update(:name=>"test")
      result = game.user.busted?
      expect(result).to be_true
    end
    
  end
  
end
