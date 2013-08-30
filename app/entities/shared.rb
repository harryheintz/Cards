module Shared
  def has_ace? 
    hand.each do |card|
      false unless card.is_ace?
    end
  end
  
  def hit
    
  end
end