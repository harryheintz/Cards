require 'dm-validations'
require 'json'

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
  
  def self.play(options)
    game = BlackjackGame.get(options[:id])
    game.process_user_hit if options[:hit] == true # pry > attributes = { :hit => true }
    game.process_user_stand if options[:stand] == true
    #game.process_user_split if attributes[:split] == true
    game
  end
  
  def process_user_hit
    #process_house_action(self.house.choice)
    hit(user)
    process_other_players
  end
  
  def process_user_stand
    #process_house_action(self.house.choice)
    process_other_players
  end
  
  def process_user_split
    #process_house_action(self.house.choice)
    process_other_players
  end
  
  def process_other_players
    
    #artificial_players.each do |ap|
     # ap.make_choice
      #process the choice
      #save the cards
      #end
  end
  
  def hit(player)
    card = create_card(get_dealer_cards(1))
    player.cards << card
    player.save
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
  
  def calculate_hand(player)
    total = 0
      player.cards.each do |card|
      total += card.value
    end

    player.cards.aces.each do |ace|
      total += evaluate_ace_score(total) #will this work if you had 2 or more aces??
    end
    total
   # evaluate_score(total)
    
  end
  
  def evaluate_ace_score(total)
    total > 10 ? 1 : 11
  end
  
  def twenty_one?(total)
    if total == 21 && user.cards.count == 2 
       blackjack_win 
     elsif
    total == 21 && user.cards.count >= 3 #this will eventually compare house.cards total and the greater total will return victory
     victory
   else
     busted?(total)
    end
     
  end
  
  def evaluate_score(player)
    total = calculate_hand(player)
    twenty_one?(total) 
  end
  
  def busted?(total)
    total > 21 ? defeat : continue
  end
  
  def blackjack_win
    "Black Jack!"
  end
  
  def victory
    "Winner"
  end
  
  def defeat
    "Defeat"
  end
  
  def continue
    "true"
  end
  
  def calculate_card_value(string)
    string.gsub!(/[JQK]/, "10" )
    string.to_i
  end
  
end
  

  

