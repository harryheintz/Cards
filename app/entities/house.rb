require_relative "./shared"
class House
  include DataMapper::Resource, Shared
  property :id,               Serial
  belongs_to :blackjack_game, :required => false
  has n, :cards
  
  def choice
    
    
  end
   
end