class Blackjack
  attr_accessor :number_of_players, :dealer, :dealer_hand
  
  def self.start(player_count)
    new(player_count)
  end
  
  def initialize(player_count)
    @number_of_players = player_count
    @dealer = Dealer.new
    @dealer_hand = cards_for_first_deal
  end
  
  def number_of_cards_for_inital_deal
    number_of_players * 2
  end
  
  def cards_for_first_deal
    @dealer.deal(number_of_cards_for_inital_deal)
  end
  
  def deal_down
    @dealer_hand.shift(2)
  end
  
  def deal_up
    @dealer_hand.shift(2)
  end
  
  
end