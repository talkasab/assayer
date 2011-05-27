require 'spec_helper'

describe MedicalRecordItem do
  let!(:procedure) { Factory.create(:medical_record_item) }

  # Relationships
  it { should belong_to(:scenario) }
  it { should belong_to(:item_type) }

  # Validations
  it { should validate_presence_of(:scenario) }
  it { should validate_presence_of(:days_from_index) }
  it { should validate_numericality_of(:days_from_index) }
  [-5, 12].each { |n| it { should allow_value(n).for(:days_from_index) } }
  [5.3, 6.7, 3.1415926].each { |n| it { should_not allow_value(n).for(:days_from_index) } }
  it { should validate_presence_of(:item_type) }
  it { should validate_presence_of(:report) }
end

