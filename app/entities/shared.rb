module Shared
  
  def can_split? #should be returned every message
    cards.first[:value] == cards.last[:value] 
  end
  
  def has_ace? 
    hand.each do |card|
      false unless card.is_ace?
    end
  end
  
  def blackjack?
    twenty_one? && cards.count == 2
  end
  
  def twenty_one?
    calculate_hand == 21
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
  #has n, :split_cards
  
end