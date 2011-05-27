require 'spec_helper'

describe ScenarioFamily do
  let!(:breastca) { Factory.create(:scenario_family, :name => "Breast Cancer") }

  # Relationships
  it { should have_many(:scenarios) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

end
