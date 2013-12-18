require_relative '../spec_helper'

describe Player do
  
  context "card labeling" do
    
    it "should return a retival-friendly hash for cards" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      card = game.user.response
      result = card.first
      expect(result).to have_key(:image_key)
    end
  end
    
  context "status" do
    
    it "should return appropriately for blackjack" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      hash_one = {:value => 10}
      hash_two = {:value => 11}
      new_hash = {:name => "test"}
      game.user.cards.update(new_hash)
      game.user.cards.first.update(hash_one)
      game.user.cards.last.update(hash_two)
      result = game.user.status
      expect(result).to eq("blackjack")
    end
    
    it "should return appropriately for twenty-one" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.hit(game.user)
      game.user.cards.fetch(0).update(:value=>10)
      game.user.cards.fetch(1).update(:value=>10)
      game.user.cards.fetch(2).update(:value=>1)
      game.user.cards.update(:name=>"test")
      result = game.user.status
      expect(result).to eq("twentyone")
    end
    
    it "should return appropriately for stand" do
      user = User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      BlackjackGame.prepare(attributes)
      options = {"game_id" => 1, "stand" => true}
      BlackjackGame.play(options)
      saved_game = BlackjackGame.get(1)
      result = saved_game.user.status
      expect(result).to eq("stand")
    end
    
    it "should return appropriatley for a house bust" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.hit(game.house)
      game.house.cards.fetch(0).update(:value=>10)
      game.house.cards.fetch(1).update(:value=>10)
      game.house.cards.fetch(2).update(:value=>10)
      game.house.cards.update(:name=>"test")
      result = game.house.status
      expect(result).to eq("busted")
    end
  end
  
  context "messages" do
    
    it "should return appropriately for blackjack" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      hash_one = {:value => 10}
      hash_two = {:value => 11}
      new_hash = {:name => "test"}
      game.user.cards.update(new_hash)
      game.user.cards.first.update(hash_one)
      game.user.cards.last.update(hash_two)
      result = game.user.message
      expect(result).to eq("Yay! Blackjack! Fireworks!!!")
    end
    
    it "should return appropriately for twenty-one" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.hit(game.user)
      game.user.cards.fetch(0).update(:value=>10)
      game.user.cards.fetch(1).update(:value=>10)
      game.user.cards.fetch(2).update(:value=>1)
      game.user.cards.update(:name=>"test")
      result = game.user.message
      expect(result).to eq("WINNER!")
    end
    
    it "should return appropriately for stand" do
      user = User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      BlackjackGame.prepare(attributes)
      options = {"game_id" => 1, "stand" => true}
      BlackjackGame.play(options)
      saved_game = BlackjackGame.get(1)
      result = saved_game.user.message
      expect(result).to eq("Stand!")
    end
    
    it "should return appropriatley for a house bust" do
      User.create
      attributes = { "number_of_players" => 3, "user_id" => 1 }
      game = BlackjackGame.prepare(attributes)
      game.hit(game.house)
      game.house.cards.fetch(0).update(:value=>10)
      game.house.cards.fetch(1).update(:value=>10)
      game.house.cards.fetch(2).update(:value=>10)
      game.house.cards.update(:name=>"test")
      result = game.house.message
      expect(result).to eq("BUSTED!")
    end
  end
end