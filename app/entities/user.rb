require_relative "./shared"
class User
  include DataMapper::Resource, Shared
  property :id,               Serial
  belongs_to :blackjack_game, :required => false
  has n, :cards

end