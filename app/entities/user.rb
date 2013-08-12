class User
  include DataMapper::Resource
  property :id,             Serial
  property :hidden_cards    Json
  
end