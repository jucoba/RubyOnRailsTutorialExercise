require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Test user", :email => "example@miiglesiaenlinea.com"  }
  end

  it "Should create a new user given vaid attributes" do
    User.create!(@attr)
  end

  it "Should require a name" do
    no_name_user = User.new( @attr.merge(:name => "") )
    no_name_user.should_not be_valid
  end

  it "Shoud require an email" do
    no_email_user = User.new( @attr.merge(:email => "") )
    no_email_user.should_not be_valid
  end

  it "Sould reject users with long names" do
    long_name = "a" * 61
    long_name_user = User.new( @attr.merge(:name => long_name) )
    long_name_user.should_not be_valid
  end

  it "Should acepts user with valid email" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address ) )
      valid_email_user.should be_valid
    end  
  end

 it "Should rejects user with valid email" do
    addresses = %w[user@foo. @foo.bar.org first.last user@foo,com ] 
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address ) )
      invalid_email_user.should_not be_valid
    end  
  end 

 it "Should reject user with duplicate email address" do
   User.create!(@attr)
   duplicate_user = User.new(@attr)
   duplicate_user.should_not be_valid
 end

 
end
