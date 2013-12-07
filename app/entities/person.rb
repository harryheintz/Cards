# require_relative "./shared"
# 
# 
# class Person 
#   include DataMapper::Resource
#   
#   email_regex = /\A[\w.\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#   property :id,                        Serial 
#   # property :username,                  String, :required => true
#   property :email,                     String, :required => true, format: email_regex
#   property :password,                  String, :required => true, length: 6..40
#   property :password_confirmation,     String, :required => true, length: 6..40
#   has 1,   :user
#  
#   
#   
#   def self.login(options)
#      
#     person = get(:email=> options[:email])
#     if person.password == options[:password]
#       response = {
#                   "email" => preson.email,
#                   "user_id" => person.user.id
#                   }
#     else
#       response = { "error" => "This email or password is invalid or incorrect." }
#     end
#   end
# 
# end
  
  

