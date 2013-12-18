require_relative "./shared"

class ArtificialPlayer < Player
   
   def hit?
      calculate_hand < 17
     #some behavior that determines if this is true
   end 
   
   def stand?
      calculate_hand > 17
     #some behavior that determines if this is true
   end
   
   def split?
     true
     #some behavior that determines if this is true
   end
   
end