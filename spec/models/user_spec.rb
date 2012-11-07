# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  churchname :string(255)
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = { name: "Test user 1", email: "example@miiglesiaenlinea.com", churchname: "Iglesia en Linea", password:"mipass", 
      :password_confirmation => "mipass"}
    @user = User.new(@attr)
  end

  subject { @user }

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:churchname)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}
  it {should respond_to(:remember_token)}
  
  it {should be_valid}
  
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      #Estas 2 lineas hacen lo mismo, se dejaron las 2 soloamente por ejemplo
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
end

  describe "When password is not present" do
    before {@user.password = @user.password_confirmation = ""}
    it {should_not be_valid}
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) {should_not be_blank}
  end

  it "Should require a name" do
  User.create(@attr)    
    no_name_user = User.new( @attr.merge(:name => "") )
    no_name_user.should_not be_valid
  end

  it "Should require a churchname" do
    no_church_user = User.new( @attr.merge(:churchname => "") )
    no_church_user.should_not be_valid
  end

  it "Shoud require an email" do
    no_email_user = User.new( @attr.merge(:email => "") )
    no_email_user.should_not be_valid
  end

  it "Should reject user with duplicate email address" do    
    User.create!(@attr)
    duplicate_user = User.new(@attr)
    duplicate_user.should_not be_valid
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

  

 it "Should rejects user with invalid email" do
   addresses = %w[user@foo. @foo.bar.org first.last user@foo,com ] 
   addresses.each do |address|
     invalid_email_user = User.new(@attr.merge(:email => address ) )
     invalid_email_user.should_not be_valid
    end  
  end 

 


end
