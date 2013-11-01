require_relative '../spec_helper'

describe ArtificialPlayer do
 
  context "validation" do
  
    it "assigns an id" do
      result = ArtificialPlayer.create
      expect(result.id).to eq 1
    end
  
  end
  
  context "setting up a card game" do
    
    it "should hold hidden cards" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      b = BlackjackGame.prepare(attributes)
      result = b.artificial_players.first
      expect(result.cards.hidden).to have(1).item
    end
    
    it "should hold visible cards" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      b = BlackjackGame.prepare(attributes)
      result = b.artificial_players.first
      expect(result.cards.visible).to have(1).item
      
    end
    
  end
  
  context "playing Blackjack" do
    
    it "should respond to hit" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.artificial_players.first.cards.fetch(0).update(:value=>5)
      game.artificial_players.first.cards.fetch(1).update(:value=>10)
      game.artificial_players.first.cards.update(:name=>"test")
      game.process_other_players
      result = game.artificial_players.first.cards
      expect(result).to have(3).items
    end
    
    it "should respond to stand" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.artificial_players.first.cards.fetch(0).update(:value=>9)
      game.artificial_players.first.cards.fetch(1).update(:value=>10)
      game.artificial_players.first.cards.update(:name=>"test")
      game.process_other_players
      result = game.artificial_players.first.cards
      expect(result).to have(2).items
      
    end
    
    it "should be able to determine if a hand is eleigble for a split" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.artificial_players.first.cards.fetch(0).update(:value=>10)
      game.artificial_players.first.cards.fetch(1).update(:value=>10)
      game.artificial_players.first.cards.update(:name=>"test")
      result = game.artificial_players.first.can_split?
      expect(result).to be_true
    end
    
    it "should respond to split" do
      pending
      #essentially, if two cards on the initial deal are face value, a plit can be called.
      #so, if the value of the hidden card is the same as the value of the visible card, split?
      #this requires a seperate "hand" that is evaluated separately, or, an attribute of :split => true.
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
      game.artificial_players.first.cards.update(new_hash)
      game.artificial_players.first.cards.first.update(hash_one)
      game.artificial_players.first.cards.last.update(hash_two)
      result = game.artificial_players.first.blackjack?
      expect(result).to be_true
    end


    it "should evaluate hand for twenty one" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.hit(game.artificial_players.first)
      game.artificial_players.first.cards.fetch(0).update(:value=>10)
      game.artificial_players.first.cards.fetch(1).update(:value=>10)
      game.artificial_players.first.cards.fetch(2).update(:value=>1)
      game.artificial_players.first.cards.update(:name=>"test")
      result = game.artificial_players.first.twenty_one?
      expect(result).to be_true
    end

    it "should evaluate hand for busted" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.hit(game.artificial_players.first)
      game.artificial_players.first.cards.fetch(0).update(:value=>10)
      game.artificial_players.first.cards.fetch(1).update(:value=>10)
      game.artificial_players.first.cards.fetch(2).update(:value=>10)
      game.artificial_players.first.cards.update(:name=>"test")
      result = game.artificial_players.first.busted?
      expect(result).to be_true
    end
    
  end
  
end
