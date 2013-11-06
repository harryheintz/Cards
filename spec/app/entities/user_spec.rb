require_relative '../spec_helper'

describe User do
 
  context "validation" do
  
    it "assigns an id" do
      result = User.create
      expect(result.id).to eq 1
    end
  
  end
  
  context "verifying a card hand" do
    
    it "should hold hidden cards" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      result = game.user.cards.first.hidden
      expect(result).to be_true 
    end
    
    
    it "should hold visible cards" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      result = game.user.cards.last.hidden
      expect(result).to be_false 
    end
  end
    
  context "game play" do
      
      it "should respond to a hit request" do
        user = User.create
        attributes = { "number_of_players" => 3, "user_id" => 1 }
        game = BlackjackGame.prepare(attributes)
        game.process_user_hit
        result = game.user.cards
        expect(result).to have(3).items
      end
      
      it "should respond to a stand request" do
        user = User.create
        attributes = { "number_of_players" => 3, "user_id" => 1 }
        saved_game = BlackjackGame.prepare(attributes)
        saved_game.process_user_stand
        result = saved_game.user.cards
        expect(result).to have(2).items
      end
      
      it "should determine if a hand is eleigble for a split" do
        User.create
        attributes = { "number_of_players" => 3, "user_id" => 1 }
        game = BlackjackGame.prepare(attributes)
        game.user.cards.fetch(0).update(:value=>10)
        game.user.cards.fetch(1).update(:value=>10)
        game.user.cards.update(:name=>"test")
        result = game.user.can_split?
        expect(result).to be_true
      end
      
      it "should respond with a split request" do
        user = User.create
        attributes = { "number_of_players" => 3, "user_id" => 1 }
        saved_game = BlackjackGame.prepare(attributes)
        saved_game.user.cards.fetch(0).update(:value=>10)
        saved_game.user.cards.fetch(1).update(:value=>10)
        saved_game.user.cards.update(:name=>"test")
        #options = {:id => saved_game.id, :hit => false, :stand => false, :split => true}
        saved_game.process_user_split
        result = saved_game.user.cards
        expect(result).to have(4).items
      end
      
      it "should hold split cards" do
        user = User.create
        attributes = { "number_of_players" => 3, "user_id" => 1 }
        saved_game = BlackjackGame.prepare(attributes)
        saved_game.user.cards.fetch(0).update(:value=>10)
        saved_game.user.cards.fetch(1).update(:value=>10)
        saved_game.user.cards.update(:name=>"test")
        #options = {:id => saved_game.id, :hit => false, :stand => false, :split => true}
        #game = BlackjackGame.play(options)
        saved_game.process_user_split
        result = saved_game.user.cards.last
        expect(result.split).to be_true
      end
  end
  
  context "hand calculation" do
    
    it "should evaluate hand for Black Jack" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
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
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.hit(game.user)
      game.user.cards.fetch(0).update(:value=>10)
      game.user.cards.fetch(1).update(:value=>10)
      game.user.cards.fetch(2).update(:value=>1)
      game.user.cards.update(:name=>"test")
      result = game.user.twenty_one?
      expect(result).to be_true
    end

    it "should evaluate hand for busted" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
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
