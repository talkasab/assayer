# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scenario do
    association :scenario_family
    patient_age 12
    patient_sex "M"
    exam_clinical_history "Pain"
    exam_description "Chest X-ray"
    exam_report "Unremarkable exam. No abnormality seen to account for patient's symptoms."
  end
end
