require 'rails_helper'

RSpec.describe "Friendships" do
	before do 
		2.times {create_user} 
		select 'TestName', from: 'friendship_friended_id'
		click_on 'Create Friendship'
	end

	it 'are created' do
		expect(Friendship.count).to eq(1)
	end

	it 'are showed' do
		within '.friends' do 
			expect(page).to have_text('TestName')
		end
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