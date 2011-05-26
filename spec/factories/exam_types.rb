# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam_type do
    sequence(:name) { |n| "ExamType#{n}" }
    description { "Longer, more detailed description of #{name}" }
  end
end
