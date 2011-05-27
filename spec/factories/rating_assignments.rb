FactoryGirl.define do
  factory :rating_assignment do
      association :rater, :factory => :user
      association :scenario_family 
      start_at { Time.now }
      end_at { 1.year.since }
    end
end
