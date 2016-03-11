require "spec_helper"

describe "User pages" do 
  subject { page }
  before {visit root_path}

  it {should have_css('#new_user')}

end