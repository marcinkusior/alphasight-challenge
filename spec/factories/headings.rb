FactoryGirl.define do
  factory :heading do
  	group 'h1'
    content "MyString"
    association :user
  end
end
