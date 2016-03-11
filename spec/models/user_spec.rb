require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryGirl.build_stubbed(:user)}
  subject {user}

  it {should be_valid}
  it {should respond_to(:name)}
  it {should respond_to(:website_url)}
  it {should respond_to(:short_url)}
  it {should respond_to(:friends)}

  it 'creates short url' do
    created_user = FactoryGirl.create(:user, website_url: "http://railscasts.com/")
    expect(created_user.short_url).to eq("http://goo.gl/pVbd")
  end

  describe 'associations' do
  	it {should have_many(:headings).dependent(:destroy)}
  	it {should have_many(:friendships).dependent(:destroy)}
    it {should have_many(:reverse_friendships).dependent(:destroy)}
    it {should have_many(:frienders)} 
    it {should have_many(:friended_users)} 
  end

  describe 'validations' do
  	it {should validate_presence_of(:name)}
  	it {should validate_presence_of(:website_url)}
  end
end

