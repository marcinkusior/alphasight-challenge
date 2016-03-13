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

  describe '#path_of_introduction' do
    before do
      for i in 1..5
        FactoryGirl.create(:user, name: "user#{i}", id: i)
      end
      FactoryGirl.create(:friendship, friender_id: 1, friended_id: 2)
      FactoryGirl.create(:friendship, friender_id: 2, friended_id: 3)
    end

    it 'return friends already when subject are friends' do
      user1, user2 = User.find(1), User.find(2)
      expect(user1.path_of_introduction(user2)).to eq(['friends already with'])
    end

    it 'returns false when connection impossible' do
      user1, user5 = User.find(1), User.find(5)
      expect(user1.path_of_introduction(user5)).to eq(['no connection with'])
    end

    it 'returns results when friendship possible' do
      user1, user3 = User.find(1), User.find(3)
      names = user1.path_of_introduction(user3)
      expect(names).to eq(['user1', 'user2'])
    end
  end

  describe '#all_paths_between' do
    before do 
      for i in 1..5
        FactoryGirl.create(:user, name: "user#{i}", id: i)
      end
      FactoryGirl.create(:heading, content: 'TestHeading', user_id: 3, id: 1)
      FactoryGirl.create(:heading, content: 'ComplexHeading', user_id: 5, id: 2)
      FactoryGirl.create(:friendship, friender_id: 1, friended_id: 2)
      FactoryGirl.create(:friendship, friender_id: 2, friended_id: 3)
      FactoryGirl.create(:friendship, friender_id: 3, friended_id: 4)
      FactoryGirl.create(:friendship, friender_id: 4, friended_id: 5)
    end

    it 'returns self when headings belongs to self' do
      heading = Heading.find(1)
      user3 = User.find(3)
      result = user3.all_paths_between([heading])
      expect(result).to eq ([['(TestHeading)', ['user3']]])
    end

    it 'returns correct result' do
      heading = Heading.find(1)
      user1 = User.find(1)
      result = user1.all_paths_between([heading])
      expect(result).to eq ([['(TestHeading)', ['user1', 'user2', 'user3']]])
    end

    it 'returns correct in complex scenarios' do
      heading = Heading.find(2)
      user1 = User.find(1)
      result = user1.all_paths_between([heading])
      expect(result).to eq ([['(ComplexHeading)', ['user1', 'user2', 'user3', 'user4', 'user5']]])
    end
  end
end

