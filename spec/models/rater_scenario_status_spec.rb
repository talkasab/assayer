require 'spec_helper'

describe RaterScenarioStatus do
  let!(:status) { Factory.create(:rater_scenario_status) }

  # Associations
  it { should belong_to(:rater) }
  it { should belong_to(:scenario) }
  
  # Validations
  it { should validate_presence_of(:rater) }
  it { should validate_presence_of(:scenario) }
  it { should validate_presence_of(:items_completed) }
  it { should validate_numericality_of(:items_completed) }
  it { [-1, 1.2].each {|n| should_not allow_value(n).for(:items_completed) } }
  it { [0, 12].each {|n| should allow_value(n).for(:items_completed) } }
  it { should validate_uniqueness_of(:scenario_id).scoped_to(:rater_id) }
end
