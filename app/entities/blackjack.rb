class Blackjack
  attr_accessor :number_of_players, :dealer
  
  def self.start(player_count)
    new(player_count)
  end
  
  def initialize(player_count)
    @number_of_players = player_count
    @dealer = Dealer.new
  end
  
  def number_of_cards_for_inital_deal
    number_of_players * 2
  end
  
  def cards_for_first_deal
    @dealer.deal(number_of_cards_for_inital_deal)
  end
  
  def deal_down
    card_down = cards_for_first_deal.shift(2)
  end
  
  def deal_up
    card_up = cards_for_first_deal.shift(2)
  end
  
  def get_hand
    cards = deal_down.shift(1)
    cards.push(deal_up.shift(1)) 
  end
  
end