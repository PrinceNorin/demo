require 'spec_helper'

describe User do
  # Test subject in other word user
  before { @user = FactoryGirl.build :user }
  subject { @user }
  
  # Test for model attributes and methods
  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_digest }
  it { should respond_to :password_confirmation }
  it { should respond_to :authenticate }
  
  describe "return value of authenticate" do
    before { @user.save }
    describe "with valid password" do
      it "should return the user object" do
        expect(@user.authenticate 'secret').to eq @user
      end
    end
    
    describe "with invalid password" do
      it "should return the user object" do
        expect(@user.authenticate 'invalid').not_to eq @user
      end
      specify { expect(@user.authenticate 'invalid').to be_false }
    end
  end
  
  describe "name" do
    describe "is not unique" do
      let(:user_with_same_name) { @user.dup }
      before do
        user_with_same_name.email = 'same_name_user@example.com'
        user_with_same_name.save
      end
      it { should_not be_valid }
    end
    
    describe "is not presence" do
      before { @user.name = '  ' }
      it { should_not be_valid }
    end
    
    describe "is too short" do
      before { @user.name = 'a' * 4 }
      it { should_not be_valid }
    end
  end
  
  describe "password" do
    describe "with blank password" do
      before do
        @user.password = '  '
        @user.password_confirmation = '  '
      end
      it { should_not be_valid }
    end
    
    describe "is too short" do
      before do
        @user.password = 'a' * 5
        @user.password_confirmation = 'a' * 5
      end
      it { should_not be_valid }
    end
    
    describe "should match password_confirmation" do
      before do
        @user.password = 'secret'
        @user.password_confirmation = 'Secret'
      end
      it { should_not be_valid }
    end
  end
  
  describe "email" do
    describe "with blank email" do
      before { @user.email = '  ' }
      it { should_not be_valid }
    end
    
    describe "with incorrect format" do
      it "should not be valid" do
        invalid_addresses = %w(@norin@example.com norin@example example.com)
        invalid_addresses.each do |address|
          @user.email = address
          expect(@user).not_to be_valid
        end
      end
    end
    
    describe "with correct format" do
      it "should be valid" do
        invalid_addresses = %w(abc@example.com elit@example.com)
        invalid_addresses.each do |address|
          @user.email = address
          expect(@user).to be_valid
        end
      end
    end
    
    describe "with duplicate" do
      let(:user_with_same_email) { @user.dup }
      before { user_with_same_email.save }
      it { should_not be_valid }
    end
    
    describe "with unique name" do
      it { should be_valid }
    end
    
    describe "should be downcase after save" do
      let(:mix_case_email) { 'User_1@EAMPLe.cOm' }
      before do
        @user.email = mix_case_email.dup
        @user.save
      end
      its(:email) { should_not eq mix_case_email }
      specify { expect(@user.email).to eq mix_case_email.downcase }
    end
  end
end
