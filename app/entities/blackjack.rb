class Blackjack
  attr_accessor :number_of_players, :dealer
  
  def self.start(player_count)
    new(player_count)
  end
  
  def initialize(player_count)
    @number_of_players = player_count
    @dealer = Dealer.new
  end
  
  def deal
    
  end
  
  def number_of_cards_for_inital_deal
    number_of_players * 2
  end
  
  def cards_for_first_deal
    @dealer.deal(number_of_cards_for_inital_deal)
  end
  
end