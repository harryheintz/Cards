require 'dm-validations'

class BlackjackGame
  include DataMapper::Resource
  property :id,                   Serial #blackjack_game.id
  property :number_of_players,    Integer, :required => true
  belongs_to :user
  has 1, :dealer
  has 1, :house
  has n, :artificial_players
  attr_accessor :initial_cards
  
  def self.start(attributes)
    game = create(attributes)
    return nil unless game.valid?
    game.dealer = Dealer.new
    game.house = House.new
    game.create_artificial_players unless game.number_of_players < 2
    game.save
    game.cards_for_first_deal
    game.deal_down
    game.deal_up
    game
  end
  
  def create_artificial_players
    ap = number_of_players - 2
    ap.downto(1) do |n|
      artificial_players << ArtificialPlayer.create
    end
  end
  
  def number_of_cards_for_initial_deal
    number_of_players * 2
  end
  
  def cards_for_first_deal
    @initial_cards = dealer.deal(number_of_cards_for_initial_deal)
  end
  
  def create_inital_cards
    collection = []
    @initial_cards.each do |initial_card|
      value = assign_value(initial_card[:name])
      attributes = { :name => initial_card[:name], :suit => initial_card[:suit], :value => value }
      card = Card.create(attributes)
      collection << card
    end
  end
  

  def deal_down
    create_inital_cards.shift
    user.visible_cards << dealt_card
    house.visible_cards << dealt_card
    artificial_players.each do |ap|
      ap.visible_cards = []
      ap.visible_cards << dealt_card
    end
    save
  end
  
  def assign_value(string)
    string.gsub!(/[JQK]/, "10" )
    string.gsub!(/[A]/, "11")
    string.to_i
  end
  
  def calculator
    #assign the values to the deck and returns "@appraised_cards"
  end
  
end
  

  

