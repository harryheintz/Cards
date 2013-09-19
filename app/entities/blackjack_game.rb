require 'dm-validations'

class BlackjackGame
  include DataMapper::Resource
  property :id,                   Serial #blackjack_game.id
  property :number_of_players,    Integer, :required => true
  belongs_to :user
  has 1, :dealer
  has 1, :house
  has n, :artificial_players
  attr_accessor :initial_cards, :hit, :split, :stand
  
  def self.start(attributes)
    game = create(attributes)
    return nil unless game.valid?
    game.dealer = Dealer.new
    game.house = House.new
    game.create_artificial_players unless game.number_of_players < 2
    game.save
    game.cards_for_first_deal
    game.first_deal
    game
  end
  
  def self.play(attributes)
    game = BlackjackGame.get(attributes[:id])
    game.process_user_action(game.hit(game.user)) if attributes[:hit] == true # pry > attributes = { :hit => true }
    #game.process_user_action(stand) if attributes[:stand] == true
    #game.process_user_action(split) if attributes[:split] == true
    game
  end
  
  def process_user_action(action)
    action
    #process_house_action(self.house.choice)
    #artificial_players.each do |ap|
     # ap.make_choice
      #process the choice
      #save the cards
      #end
  end
  
  def create_artificial_players
    ap = number_of_players - 2
    ap.downto(1) do |n|
      self.artificial_players << ArtificialPlayer.create
    end
    self.save
  end
  
  def number_of_cards_for_initial_deal
    number_of_players * 2
  end
  
  def cards_for_first_deal
    @initial_cards = dealer.deal(number_of_cards_for_initial_deal)
  end
  
  def get_dealer_cards(count)
    @card_request = dealer.deal(count)
  end
  
  def first_deal
    associate_down_card_for(user)
    associate_down_card_for(house)
    artificial_players.each do |ap|
      associate_down_card_for(ap)
    end
    associate_up_card_for(user)
    associate_up_card_for(house)
    artificial_players.each do |ap|
      associate_up_card_for(ap)
    end
  end
  
  def associate_up_card_for(player)
    card = create_card(@initial_cards.shift)
    player.cards << card
    player.save
  end
  
  def associate_down_card_for(player)
    card = create_card(@initial_cards.shift, true)
    player.cards << card
    player.save
  end
  
  def create_card(card_hash, hidden=false)
    value = calculate_card_value(card_hash[:name])
    attributes = { :name => card_hash[:name], :suit => card_hash[:suit], :value => value, :hidden => hidden}
    card = Card.create(attributes)
  end
  
  def calculate_hand(player)
    total = 0
      player.cards.each do |card|
      total += card.value
    end

    player.cards.aces.each do |ace|
      total += evaluate_ace_score(total) #will this work if you had 2 or more aces??
    end
    total
  end
  
  def evaluate_ace_score(total)
    total > 10 ? 1 : 11
  end
  
  def calculate_card_value(string)
    string.gsub!(/[JQK]/, "10" )
    string.to_i
  end
  
  def hit(player)
    game.get_dealer_cards(1)
    card = create_card(@card_request.shift)
    player.cards << card
    player.save
  end
  
end
  

  

