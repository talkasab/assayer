require 'spec_helper'

describe Scenario do
  # Relationships
  it { should belong_to(:scenario_family) }
  it { should belong_to(:index_exam_type) }

  # Validations
  it { should validate_presence_of(:scenario_family) }
  it { should validate_presence_of(:patient_age) }
  it { should validate_numericality_of(:patient_age) }
  it { should_not allow_value(-5).for(:patient_age) }
  it { should_not allow_value(150).for(:patient_age) }
  it { should validate_presence_of(:patient_sex) }
  it { should allow_value('M').for(:patient_sex) }
  it { should allow_value('F').for(:patient_sex) }
  it { ['X', 'A', 'G' 'B', 'C'].each {|l| should_not allow_value(l).for(:patient_sex) } }
  it { should validate_presence_of(:index_exam_type) }
  it { should validate_presence_of(:index_exam_clinical_history) }
  it { should validate_presence_of(:index_exam_report) }
end
