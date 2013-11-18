require_relative "./shared"


class Person 
  include DataMapper::Resource
  
  email_regex = /\A[\w.\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  property :id,                        Serial 
  property :username,                  String, :required => true
  property :email,                     String, :required => true, format: email_regex
  property :password,                  String, :required => true, length: 6..40
  property :password_confirmation,     String, :required => true, length: 6..40
  has n,   :blackjack_games
end 
  
  
  

