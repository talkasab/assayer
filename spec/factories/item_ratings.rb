# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item_rating do
    association :item, :factory => :medical_record_item
    association :rater, :factory => :user
    rating 1
  end
end
