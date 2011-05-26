# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scenario do
    association :scenario_family
    patient_age 12
    patient_sex "M"
    association :index_exam_type, :factory => :exam_type
    index_exam_clinical_history "MyText"
    index_exam_report "MyText"
  end
end
