require_relative "./shared"

class ArtificialPlayer < Player
   
   def ap_hit?
      calculate_hand < 17
     #some behavior that determines if this is true
   end 
   
   def ap_stand?
      calculate_hand > 17
     #some behavior that determines if this is true
   end
   
   def ap_split?
     true
     #some behavior that determines if this is true
   end
end