require 'rails_helper'

RSpec.describe Heading, type: :model do
  let(:heading) {FactoryGirl.create(:heading)}
  subject {heading}

  it {should be_valid}
  it {should respond_to(:group)}
  it {should respond_to(:content)}
  it {should respond_to(:user_id)}

  describe 'associations' do
  	it {should belong_to(:user)}  	
  end

  describe 'validations' do
  	it {should validate_presence_of(:group)}
  	it {should validate_presence_of(:content)}
  end
end
