require_relative '../spec_helper'
require_relative '../../../app/entities/artificial_player'
require_relative '../../../app/entities/blackjack_game'
require_relative '../../../app/entities/user'
require_relative '../../../app/entities/dealer'
require_relative '../../../app/entities/card_deck'
require_relative '../../../app/entities/house'
require_relative '../../../app/entities/cardfaces'
require_relative '../../../app/entities/card'



describe ArtificialPlayer do
 
  context "validation" do
  
    it "assigns an id" do
      result = ArtificialPlayer.create
      expect(result.id).to eq 1
    end
  
  end
  
  context "playing a card game" do
    
    it "should hold hidden cards" do
      attributes = { number_of_players: 3, user: User.create }
      b = BlackjackGame.start(attributes)
      result = b.artificial_players.first
      expect(result.cards.hidden).to have(1).item
    end
    
    it "should hold visible cards" do
      attributes = { number_of_players: 3, user: User.create }
      b = BlackjackGame.start(attributes)
      result = b.artificial_players.first
      expect(result.cards.visible).to have(1).item
      
    end
    
  end
  
  context "playing Blackjack" do
    
    it "should respond to hit" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      game.artificial_players.first.cards.fetch(0).update(:value=>5)
      game.artificial_players.first.cards.fetch(1).update(:value=>10)
      game.artificial_players.first.cards.update(:name=>"test")
      game.process_other_players
      result = game.artificial_players.first.cards
      expect(result).to have(3).items
    end
    
    it "should respond to stand" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      game.artificial_players.first.cards.fetch(0).update(:value=>9)
      game.artificial_players.first.cards.fetch(1).update(:value=>10)
      game.artificial_players.first.cards.update(:name=>"test")
      game.process_other_players
      result = game.artificial_players.first.cards
      expect(result).to have(2).items
      
    end
    
    it "should respond to split" do
      pending
    end
    
  end
  
  context "hand calculation" do
    
    it "should evaluate hand for Black Jack" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
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
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
      game.hit(game.artificial_players.first)
      game.artificial_players.first.cards.fetch(0).update(:value=>10)
      game.artificial_players.first.cards.fetch(1).update(:value=>10)
      game.artificial_players.first.cards.fetch(2).update(:value=>1)
      game.artificial_players.first.cards.update(:name=>"test")
      result = game.artificial_players.first.twenty_one?
      expect(result).to be_true
    end

    it "should evaluate hand for busted" do
      attributes = { number_of_players: 3, user: User.create }
      game = BlackjackGame.start(attributes)
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
