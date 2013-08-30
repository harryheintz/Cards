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
    d = c.gsub(/[JQK]/, "10" )
    e = d.gsub(/[A]/, "11")
    @stripped = e.gsub(/[z]/, " ")
    @valued_cards = @stripped.split.map { |x| x.to_i }
    @valued_cards
  end 
  
  def hit
    
  end
end