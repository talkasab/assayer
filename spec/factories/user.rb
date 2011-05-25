FactoryGirl.define do
  factory :user do
    name "Randall Waterhouse"
    sequence(:email) { |n| "user#{n}@factory.com" }
    password "america"
    password_confirmation { password }
    admin false
  end
end
