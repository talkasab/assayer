require 'spec_helper'

describe ExamType do
  let!(:livermri) { Factory.create(:exam_type, :name => "Liver MRI") }
  specify { ExamType.count.should == 1 }

  # Relationships
  it { should have_many(:scenarios) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
