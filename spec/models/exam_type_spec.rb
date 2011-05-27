require 'spec_helper'

describe ExamType do
  let!(:mammogram) { Factory.create(:exam_type, :name => "Mammogram") }

  # Relationships
  it { should have_many(:scenarios) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
