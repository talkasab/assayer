# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scenario do
      scenario_family_id 5
      patient_age 12
      patient_sex "M"
      index_exam_type 12
      index_exam_clinical_history "MyText"
      index_exam_report "MyText"
    end
end
