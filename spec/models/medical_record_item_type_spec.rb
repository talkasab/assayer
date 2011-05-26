require 'spec_helper'

describe MedicalRecordItemType do
  let!(:opnote) { Factory.create(:medical_record_item_type, :name => "Op Note") }
  specify { MedicalRecordItemType.count.should == 1 }

  # Relationships
  it { should have_many(:medical_record_items) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
