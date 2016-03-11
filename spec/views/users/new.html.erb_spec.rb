require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :name => "MyString",
      :website_short => "MyString",
      :short_url => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_website_short[name=?]", "user[website_short]"

      assert_select "input#user_short_url[name=?]", "user[short_url]"
    end
  end
end
