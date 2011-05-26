# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scenario_family do
    sequence(:name) { |n| "ScenFam#{n}" }
    description { "Longer, more detailed description of #{name}" }
  end
end
