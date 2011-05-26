# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :medical_record_item_type do
    sequence(:name) { |n| "MedicalRecordItemType#{n}" }
    description { "Longer description of #{name}, possibly going on at some length." }
  end
end
