# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rater_scenario_status do
    association :rater, :factory => :user
    association :scenario
    started_at nil
    finished_at nil
  end
end
