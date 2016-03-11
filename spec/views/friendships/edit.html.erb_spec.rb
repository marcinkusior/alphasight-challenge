require 'rails_helper'

RSpec.describe "friendships/edit", type: :view do
  before(:each) do
    @friendship = assign(:friendship, Friendship.create!(
      :friender_id => 1,
      :friended_id => 1
    ))
  end

  it "renders the edit friendship form" do
    render

    assert_select "form[action=?][method=?]", friendship_path(@friendship), "post" do

      assert_select "input#friendship_friender_id[name=?]", "friendship[friender_id]"

      assert_select "input#friendship_friended_id[name=?]", "friendship[friended_id]"
    end
  end
end
