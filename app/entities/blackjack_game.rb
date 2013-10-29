require_relative "./shared"
require 'dm-validations'
require 'json' 

class BlackjackGame
  include DataMapper::Resource
  property :id,                   Serial #blackjack_game.id
  property :number_of_players,    Integer, :required => true
  has n, :players
  has 1, :dealer
  has 1, :house
  has 1, :user
  has n, :artificial_players
  attr_accessor :initial_cards, :hit, :split, :stand, :message
  
  def self.start(request_attributes)
    parsed_attributes = JSON.parse(request_attributes)
    user = User.get(parsed_attributes["user_id"])
    attributes = {:user => user, :number_of_players => parsed_attributes["number_of_players"]}
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
  
  def self.play(options)
    game = BlackjackGame.get(options[:id])
    game.process_user_hit if options[:hit] == true # pry > attributes = { :hit => true }
    game.process_user_stand if options[:stand] == true
    game.process_user_split if options[:split] == true
    #calculate all of the hands and determine if there is a winner
    #if a player wins or the house busts, end the game
    game
    # returned message should be something like --> 
    # response =  {:game_over => game_over?, :winner => "winner's name", :push => "tying players' name", :bust => "busted player" 
    #    {:user_cards => "some cards", :split => false} 
#        {:house_cards => "some cards"} 
#        {:artificial_player_cards => "some cards", :split => false} }
  end
  
  def process_user_hit
    hit(user)
    process_other_players
    process_house_action
  end
  
  def process_user_stand
    process_other_players
    process_house_action
  end
  
  def process_user_split
     hit_split(user)
     hit_split(user)
    #split_cards = [] <-- should not need this if set up in DataMapper
    #split_cards = user.cards.shift <--
    #hit(user)
    #hit_split(user) : <-- else,
     process_other_players
     process_house_action
  end
  
  def process_house_action
    hit(house) if house.house_hit? == true
    @message = game_over?  
  end
  
  def process_other_players
    artificial_players.each do |ap|
      hit(ap) if ap.ap_hit?
    end
  end
  
  def hit(player)
    card = create_card(get_dealer_cards(1))
    player.cards << card
    player.save
  end
  
  def hit_split(player)
    card = create_card(get_dealer_cards(1), hidden=false, split=true)
    player.cards << card
    player.save  
  end
  
  def calculate_card_value(string)
    string.gsub!(/[JQK]/, "10" )
    string.to_i
  end
  
  def blackjack_win?
    answers = players.map { |player| player.blackjack? }
    answers.include?(true)
  end
  
  def first_round_push?
    answers = players.map { |player| player.blackjack? }
    answers.include?(true) && is_push?
  end
  
  def is_push?
    answers = players.map { |player| player.twenty_one? }
    answers.count(true) > 1
  end
  
  def is_winner?    
    answers = players.map { |player| player.twenty_one? }
    answers.include?(true)
  end
  
  def card_exhaustion?
    dealer.deck.count < number_of_players * 1
  end
  
  def game_over? #should be returned every message
    house.busted? | is_winner? | blackjack_win?
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
    hash = dealer.deal(count).shift
    hash = hash.inject({}){|card,(a,b)| card[a.to_sym] = b; card}
    hash
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
    card = create_card(@initial_cards.shift, hidden=true)
    player.cards << card
    player.save
  end
  
  def create_card(card_hash, hidden=false, split=false)
    value = calculate_card_value(card_hash[:name])
    attributes = { :name => card_hash[:name], :suit => card_hash[:suit], :value => value, :hidden => hidden, :split => split}
    card = Card.create(attributes)
  end
  
end
  

  

