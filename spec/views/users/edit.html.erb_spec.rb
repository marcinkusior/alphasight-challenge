require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :name => "MyString",
      :website_short => "MyString",
      :short_url => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_website_short[name=?]", "user[website_short]"

      assert_select "input#user_short_url[name=?]", "user[short_url]"
    end
  end
end
