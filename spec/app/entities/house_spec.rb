require_relative '../spec_helper'

describe House do
 
  context "validation" do
  
    it "assigns an id" do
      result = House.create
      expect(result.id).to eq 1
    end
  
  end
  
  context "setting up a card game" do
    
    it "should hold hidden cards" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      result = game.house.cards.first.hidden
      expect(result).to be_true 
    end
    
    it "should hold visible cards" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      result = game.house.cards.last.hidden
      expect(result).to be_false 
    end
    
  end
  
  context "playing Blackjack" do
    
    it "should know when to respond with hit option" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.house.cards.fetch(0).update(:value=>5)
      game.house.cards.fetch(1).update(:value=>10)
      game.house.cards.update(:name=>"test")
      game.process_house_action
      result = game.house.cards
      expect(result).to have(3).items      
    end
    
    it "should know when to respond with stand option" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.house.cards.fetch(0).update(:value=>8)
      game.house.cards.fetch(1).update(:value=>10)
      game.house.cards.update(:name=>"test")
      game.process_house_action
      result = game.house.stand?
      expect(result).to be_true
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
      game.house.cards.update(new_hash)
      game.house.cards.first.update(hash_one)
      game.house.cards.last.update(hash_two)
      result = game.house.blackjack?
      expect(result).to be_true
    end


    it "should evaluate hand for twenty one" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.hit(game.house)
      game.house.cards.fetch(0).update(:value=>10)
      game.house.cards.fetch(1).update(:value=>10)
      game.house.cards.fetch(2).update(:value=>1)
      game.house.cards.update(:name=>"test")
      result = game.house.twenty_one?
      expect(result).to be_true
    end

    it "should evaluate hand for busted" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.hit(game.house)
      game.house.cards.fetch(0).update(:value=>10)
      game.house.cards.fetch(1).update(:value=>10)
      game.house.cards.fetch(2).update(:value=>10)
      game.house.cards.update(:name=>"test")
      result = game.house.busted?
      expect(result).to be_true
    end
    
  end
  
end
