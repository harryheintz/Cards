class Card
  include DataMapper::Resource
  property :id,               Serial
  property :name,             String
  property :value,            Integer
  property :suit,             String
  property :hidden,           Boolean, :default => false
  belongs_to :user, :required => false
  belongs_to :house, :required => false
  belongs_to :artificial_player, :required => false
  
  
  def self.hidden
    all(:hidden => true)
  end
  
  def self.visible
    all(:hidden => false)
  end
  
  def self.excluding_aces
    all(:name.not => "A")
  end
  
  def self.aces
    all(:name => "A")
  end

  def self.clubs
    all(:suit => "Clubs")
  end
  
  def self.hearts
    all(:suit => "Hearts")
  end
  
  def self.diamonds
    all(:suit => "Diamonds")
  end
  
  def self.spades
    all(:suit => "Spades")
  end
  
  def is_ace?
    name = "A"
  end
end