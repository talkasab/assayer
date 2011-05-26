require 'spec_helper'

describe ScenarioFamily do
  let!(:livermri) { Factory.create(:scenario_family, :name => "Liver MRI") }
  specify { ScenarioFamily.count.should == 1 }

  # Relationships
  it { should have_many(:scenarios) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

end
