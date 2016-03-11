require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :name => "Name",
      :website_short => "Website Short",
      :short_url => "Short Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Website Short/)
    expect(rendered).to match(/Short Url/)
  end
end
