require_relative "./shared"
class User < Player
  include Shared 

  attr_accessor  :hit, :stand, :split
  
  def stand?
    ["stand"] == true
  end

end