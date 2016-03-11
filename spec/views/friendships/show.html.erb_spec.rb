require 'rails_helper'

RSpec.describe "friendships/show", type: :view do
  before(:each) do
    @friendship = assign(:friendship, Friendship.create!(
      :friender_id => 1,
      :friended_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
