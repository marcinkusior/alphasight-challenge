require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:friender) { FactoryGirl.create(:user) }
  let(:friended) { FactoryGirl.create(:user) }
  let(:friendship) { friender.friendships.build(friended_id: friended.id) }
  subject { friendship }

  it { should be_valid }
  it { should respond_to(:friender) }
  it { should respond_to(:friended) }

  it 'should make correct friender association' do
  	expect(friendship.friender).to eq(friender)
  end	

  it 'should make correct friended association' do
  	expect(friendship.friended).to eq(friended)
  end	

  describe "associations" do 
    it { should belong_to(:friender) }
    it { should belong_to(:friended) }
  end

  describe "validations" do 
    it { should validate_presence_of(:friended_id) }
    it { should validate_presence_of(:friender_id) }
  end
end
