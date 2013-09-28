require_relative "./shared"
class House < Player
  
  def house_hit?
    calculate_hand < 17
  end
  
end