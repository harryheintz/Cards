class Blackjack 
  attr_accessor :number_of_players, :dealer, :intial_cards
  
  def self.start(player_count, user)
    new(player_count, user)
  end
  
  def initialize(player_count, user)
    @number_of_players = player_count
    @user = user
    @dealer = Dealer.new
    cards_for_first_deal
  end
  
  def number_of_cards_for_inital_deal
    number_of_players * 2
  end
  
  def cards_for_first_deal
    @intial_cards = @dealer.deal(number_of_cards_for_inital_deal)
  end
  
  def deal_down
    @intial_cards.shift(@number_of_players)
  end
  
  def deal_up
    @intial_cards.shift(@number_of_players)
  end
  
  
end