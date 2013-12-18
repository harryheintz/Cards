# require_relative '../spec_helper'
# 
# describe Person do
#   
#  
#      before(:each) do
#      @attr={
#       :username=>"Example User", 
#       :email=> "user@example.com",
#       :password=> "foobar",
#       :password_confirmation=> "foobar"
#      }
#      
#      end
#  
#     it "should create a new instance given valid attributes" do
#       Person.create(@attr)
#     end
# 
#      it "should require a name" do
#        result = no_name_user = Person.new(@attr.merge(:username=>""))
#        expect(result).to_not be_valid
#      end
#  
#      it "should require an email address" do
#        result = no_email_user = Person.new(@attr.merge(:email=>""))
#        expect(result).to_not be_valid
#      end
#  
#      it "should reject names that are too long" do
#        long_name = "a"*51
#        result = long_name_user = Person.new(@attr.merge(:username=>long_name))
#        expect(result).to_not be_valid 
#      end
#  
#      it "should have an id" do
#        person = Person.create(@attr)
#        result = person.id
#        expect(result).to eq 1
#      end
#      
#      it "should accept valid email addresses" do
#         addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
#         addresses.each do |address|
#         result = valid_email= Person.new(@attr.merge(:email => address))
#         expect(result).to be_valid
#      end
#    end
#    
#      it "should reject invalid email addresses" do
#         addresses = %w[user@foo,com User_at_foo.com example.user@foo.]
#         addresses.each do |address|
#           result = invalid_email = Person.new(@attr.merge(:email=>address))
#       expect(result).to_not be_valid
#         end
#      end
#      
#      it "should reject duplicate user names" do
#        Person.create!(@attr)
#        person_with_duplicate_email = Person.new(@attr)
#        result = person_with_duplicate_email
#        expect(result).to_not be_valid
#     end
# 
# end