require 'spec_helper'

describe Entry do
  let(:user) { FactoryGirl.create :user }
  let(:entry) { FactoryGirl.build :entry, user: nil }
  
  it { should respond_to :title }
  it { should respond_to :body }
  it { should respond_to :user }
  
  it "should belongs to a user" do
    expect(entry).not_to be_valid
  end
end
