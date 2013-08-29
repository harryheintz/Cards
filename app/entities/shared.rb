module Shared

  def hand
    hand = []
    hand << self.visible_cards
    hand.push << self.hidden_cards
    hand.flatten!
    hand
  end
  
  def stripper
    @stripped = self.hand
    a = @stripped.to_s
    b = a.gsub(/[,]/, "z") 
    c = b.gsub(/[SpadesHeartsDiamondsClubs\W]/, "")
    d = c.gsub(/[JQKA]/, "10" )
    @stripped = d.gsub(/[z]/, " ")
    @valued_cards = @stripped.gsub(/\d/) { |x| x.to_i}
    @valued_cards
  end 
  
  def hit
    
  end
end