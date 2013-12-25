
module Outcomes
  
  def blackjack_win?
    answers = players.map { |player| player.blackjack? }
    answers.include?(true)
  end
  
  def first_round_push? # on start
    answers = players.map { |player| player.blackjack? }
    answers.include?(true) && is_push?
  end
  
  def is_push? # every message
    answers = players.map { |player| player.twenty_one? }
    answers.count(true) > 1
  end
  
  def is_winner? # every message   
    answers = players.map { |player| player.twenty_one? }
    answers.include?(true)
  end
  
  def card_exhaustion? #every message
    dealer.deck.count < number_of_players * 1
  end
  
  def game_over? #every message
    house.busted? | is_winner? | blackjack_win? | user.busted?
  end
  
end

module Procedures
  
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
  end
  
  def process_other_players
    artificial_players.each do |ap|
      hit(ap) if ap.hit?
    end
  end
  
end

module Shared
  
  def can_split?
    cards.first[:value] == cards.last[:value] 
  end
  
  def has_ace? 
    hand.each do |card|
      false unless card.is_ace?
    end
  end
  
  def blackjack?
    calculate_hand == 21 && cards.count == 2
  end
  
  def twenty_one?
    calculate_hand == 21 && cards.count > 2
  end
  
  def busted?
    calculate_hand > 21
  end
  
  def calculate_hand
    total = 0
      cards.each do |card|
      total += card.value
    end

    cards.aces.each do |ace|
      total += evaluate_ace_score(total)
    end
    total
  end
  
  def evaluate_ace_score(total)
    total > 10 ? 1 : 11
  end
 
end



class Player
  include DataMapper::Resource, Shared
  property :id,                Serial
  property :type,              Discriminator
  belongs_to :blackjack_game, :required => false
  has n, :cards
  has n, :split_cards
  
  def response
    response = []
    cards.each do |card|
      response << card.response
    end
    response
  end
  
  def status
    case
    when blackjack?
      "blackjack" 
    when twenty_one?
      "twentyone"
    when stand?
      "standing"
    when busted? 
      "busted"
    else
      "continue"
    end
  end
  
  def message
    case
      when blackjack? 
        "Yay! Blackjack! Fireworks!!!"
      when twenty_one?
        "WINNER!"
      when stand?
        "Stand!"
      when busted?
        "BUSTED!" 
      else
         "Play on!"
    end
  end
  
end