require 'spec_helper'

describe AssignmentStatusObserver do
  let!(:rater) { Factory.create(:user) }
  let!(:family) { Factory.create(:scenario_family) }
  let!(:assignment) { Factory.create(:rating_assignment, :rater => rater, :scenario_family => family) }
  let!(:scenarios) { (1..3).map { Factory.create(:scenario, :scenario_family => family) } }

  specify { family.should have(3).scenarios }

  it "should move to finished status when all the scenarios are finished" do
    assignment.should have(3).incomplete_scenarios
    scenarios.each do |s|
      assignment.status.should == :current
      RaterScenarioStatus.create(:rater => rater, :scenario => s, :finished_at => Time.now)
    end
    assignment.reload
    assignment.should have(0).incomplete_scenarios
    assignment.status.should == :finished
  end
end
