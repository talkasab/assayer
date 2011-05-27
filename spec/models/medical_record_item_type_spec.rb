require 'spec_helper'

describe MedicalRecordItemType do
  # Relationships
  it { should have_many(:medical_record_items) }

  # Validations
  it { should validate_presence_of(:code) }
  it { should validate_uniqueness_of(:code) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
