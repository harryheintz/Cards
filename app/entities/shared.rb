module Shared

  def hand
    hand = []
    hand << self.visible_cards
    hand.push << self.hidden_cards
    hand
  end
  
  def stripper
    @stripped = self.hand
    a = @stripped.to_s
    @stripped= a.scan(/\d|[JQKA]/)
    @stripped
    #cards.map{|c| c =~ /\d|[JQKA]/}      
  end 
  
  def hit
    
  end
end