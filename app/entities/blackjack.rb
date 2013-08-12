class Blackjack 
  attr_accessor :number_of_players, :dealer, :initial_cards, :down_cards, :up_cards, :house_cards, :player_cards
  
  def self.start(player_count, user)
    new(player_count, user)
    #get_hand
    #json_response = { blah }
  end
  
  def initialize(player_count, user)
    @number_of_players = player_count
    @user = user
    @dealer = Dealer.new
    cards_for_first_deal
  end
  
  def number_of_cards_for_initial_deal
    number_of_players * 2
  end
  
  def cards_for_first_deal
    @initial_cards = @dealer.deal(number_of_cards_for_initial_deal)
  end
  
  def deal_down
     @down_cards = @initial_cards.shift(@number_of_players)
  end
  
  def deal_up
    @up_cards = @initial_cards.shift(@number_of_players) 
  end
  
  def get_hand
    deal_up
    deal_down
    @player_cards = []
    @player_cards << @down_cards.shift(1)
    @player_cards << @up_cards.shift(1)
    @house_cards = []
    @house_cards << @up_cards.shift(1)
    @house_cards << @down_cards.shift(1)
  end
  
  
end