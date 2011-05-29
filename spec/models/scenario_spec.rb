require 'spec_helper'

describe Scenario do
  report =<<-END
    FINDINGS:
    Microcalcifications and architectural distortion concerning for malignancy. Biopsy is recommended. 
    
    IMPRESSION:
    BIRADS 4.
  END
  let!(:breastca1) do 
    Factory.create(:scenario, :patient_age => 58, :patient_sex => 'F',
     :exam_description => "Mammogram", :exam_clinical_history => "Lump",
     :exam_report => report)
   end

  # Relationships
  it { should belong_to(:scenario_family) }
  it { should have_many(:items) }
  it { should have_many(:rater_statuses) }
  it { should have_many(:raters) }

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
  it { should validate_presence_of(:exam_description) }
  it { should validate_presence_of(:exam_clinical_history) }
  it { should validate_presence_of(:exam_report) }
end
