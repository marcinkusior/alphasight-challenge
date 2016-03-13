require "spec_helper"

describe "Users page" do 
  subject { page }
  before {visit root_path}

  it {should have_css('#new_user')}

  describe 'user form' do
  	before {create_user}

	  it 'creates a user' do
	  	expect(User.count).to eq(1)
	  end
	end

  describe 'user index' do
  	before do 
  		create_user
  		visit root_path 
  	end
  	it{should have_content('TestName')}
  	it{should have_content('http://railscasts.com/')}
  end

  describe 'user show' do
		before{ 2.times{create_user} }

  	it {should have_content('TestName')}
  	it {should have_content('http://railscasts.com/')}
  	it {should have_content('shorturl')}
  end
end

#helpers

def create_user
	visit root_path
	within('#new_user') do
		dummy = stub(short_url: 'shorturl')
		Googl.expects(:shorten).returns(dummy)
		fill_in 'user_name',	with: 'TestName'
		fill_in 'user_website_url', with: 'http://railscasts.com/'
		click_on 'Create User'
	end
end