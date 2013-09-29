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
  
  def self.play(options)
    game = BlackjackGame.get(options[:id])
    game.process_user_hit if options[:hit] == true # pry > attributes = { :hit => true }
    game.process_user_stand if options[:stand] == true
    #game.process_user_split if attributes[:split] == true
    #calculate all of the hands and determine if there is a winner
    #if a player wins or the house busts, end the game
    game
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
  
  def calculate_card_value(string)
    string.gsub!(/[JQK]/, "10" )
    string.to_i
  end
  
  def blackjack_win?
    user.blackjack? | house.blackjack?
    # players.each do |player|
 #      player.blackjack?
 #    end
  end
  
  def is_push?
    user.twenty_one? && house.twenty_one? 
    # artificial_players.each do |ap|
 #      ap.twenty_one?
 #     end
  end
  
  def is_winner?
    user.twenty_one? | house.twenty_one?
    # players.each do |player|
#       player.twenty_one?
#     end
  end
  
  def game_over?
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
    card = create_card(@initial_cards.shift, true)
    player.cards << card
    player.save
  end
  
  def create_card(card_hash, hidden=false)
    value = calculate_card_value(card_hash[:name])
    attributes = { :name => card_hash[:name], :suit => card_hash[:suit], :value => value, :hidden => hidden}
    card = Card.create(attributes)
  end
  
end
  

  

