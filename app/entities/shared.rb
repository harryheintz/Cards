module Shared

  def hand
    hand = []
    hand << self.visible_cards
    hand.push << self.hidden_cards
    hand
  end
  
  def stripper
    cards = self.hand
    strip =  /\d|[JQKA]/
    cards.each do |c|
      c =~ strip
    end
    #cards.map{|c| c =~ /\d|[JQKA]/}      
  end 
end