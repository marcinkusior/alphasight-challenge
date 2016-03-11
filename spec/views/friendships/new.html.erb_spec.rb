require 'rails_helper'

RSpec.describe "friendships/new", type: :view do
  before(:each) do
    assign(:friendship, Friendship.new(
      :friender_id => 1,
      :friended_id => 1
    ))
  end

  it "renders new friendship form" do
    render

    assert_select "form[action=?][method=?]", friendships_path, "post" do

      assert_select "input#friendship_friender_id[name=?]", "friendship[friender_id]"

      assert_select "input#friendship_friended_id[name=?]", "friendship[friended_id]"
    end
  end
end
