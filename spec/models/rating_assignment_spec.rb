require 'spec_helper'

describe RatingAssignment do
  let!(:assignment) { Factory.create(:rating_assignment) }

  # Associations
  it { should belong_to(:rater) }
  it { should belong_to(:scenario_family) }

  # Validations
  it { should validate_presence_of(:rater) }
  it { should validate_presence_of(:scenario_family) }
  it { should_not validate_presence_of(:start_at) }
  it { should validate_uniqueness_of(:rater_id).scoped_to(:scenario_family_id) }

  # Current/expired/pending/finished logic
  it "should be current (not pending) with blank start_at" do
    rating = Factory.create(:rating_assignment, :start_at => nil)
    rating.status.should == :current
    rating.should be_current
    rating.should_not be_pending
    RatingAssignment.current.all.should include(rating)
    RatingAssignment.pending.all.should_not include(rating)
    rating.mark_finished!
    rating.status.should == :finished
    rating.should_not be_current
    RatingAssignment.current.all.should_not include(rating)
  end

  it "should be pending with a future start_at date" do
    rating = Factory.create(:rating_assignment, :start_at => 1.day.since)
    rating.status.should == :pending
    rating.should_not be_current
    rating.should be_pending
    RatingAssignment.current.all.should_not include(rating)
    RatingAssignment.pending.all.should include(rating)
    rating.mark_finished!
    rating.status.should == :finished
    rating.should_not be_pending
    RatingAssignment.pending.all.should_not include(rating)
  end

  it "should be current (not expired) with a blank end_at" do
    rating = Factory.create(:rating_assignment, :end_at => nil)
    rating.status.should == :current
    rating.should be_current
    rating.should_not be_expired
    RatingAssignment.current.all.should include(rating)
    RatingAssignment.expired.all.should_not include(rating)
  end

  it "should be expired with a past end_at date" do
    rating = Factory.create(:rating_assignment, :end_at => 1.day.ago)
    rating.status.should == :expired
    rating.should_not be_current
    rating.should be_expired
    RatingAssignment.current.all.should_not include(rating)
    RatingAssignment.expired.all.should include(rating)
    rating.mark_finished!
    rating.status.should == :finished
    rating.should_not be_expired
    RatingAssignment.expired.all.should_not include(rating)
  end

  it "should be finished when finished_at is set" do
    rating = Factory.create(:rating_assignment)
    rating.should_not be_finished
    rating.mark_finished!
    rating.should be_finished
    rating.status.should == :finished
    RatingAssignment.finished.all.should include(rating)
    RatingAssignment.current.all.should_not include(rating)
  end

  describe "Knowing which scenarios need to be completed" do 
    let!(:family) { Factory.create(:scenario_family) }
    let!(:scenarios) { (1..3).map { Factory.create(:scenario, :scenario_family => family) } }
    let!(:user) { Factory.create(:user) }
    let!(:assignment) { Factory.create(:rating_assignment, :scenario_family => family, :rater => user) }

    it "should know which scenarios need to be completed" do
      assignment.should have(3).incomplete_scenarios
    end

    it "should know that one has been completed when it's marked done" do
      assignment.should have(3).incomplete_scenarios
      user.scenario_statuses.create(:scenario => scenarios[0], :finished_at => 1.day.ago)
      assignment.should have(2).incomplete_scenarios
      assignment.incomplete_scenarios.should_not include(scenarios[0])
    end
  end

  describe "determine whether a user is currently assigned" do
    let!(:scenario) { Factory.create(:scenario, :scenario_family => assignment.scenario_family) }
    let!(:user) { assignment.rater }

    specify { RatingAssignment.user_assigned_to_scenario?(user, scenario).should be_true }
    it "should not show as assigned when pending" do
      assignment.update_attributes(:start_at => DateTime.tomorrow)
      assignment.status.should == :pending
      RatingAssignment.user_assigned_to_scenario?(user, scenario).should be_false
    end

    it "should not show as assigned when expired" do
      assignment.update_attributes(:end_at => DateTime.yesterday)
      assignment.status.should == :expired
      RatingAssignment.user_assigned_to_scenario?(user, scenario).should be_false
    end

    it "should not show as assigned when finished" do
      assignment.update_attributes(:finished_at => DateTime.yesterday)
      assignment.status.should == :finished
      RatingAssignment.user_assigned_to_scenario?(user, scenario).should be_false
    end
  end

  describe "should pull up the next scenario in an assignment" do
    let!(:scenarios) { (1..3).map { Factory.create(:scenario, :scenario_family => assignment.scenario_family) } }
    let!(:statuses) { scenarios.map {|s| RaterScenarioStatus.create(:rater_id => user, :scenario => s) } }
    let!(:user) { assignment.rater }

    it "calling next_scenario() repeatedly should work down the list" do
      assignment.should have(3).incomplete_scenarios
      assignment.next_scenario.should == scenarios[0]
      statuses[0].mark_finished!
      assignment.next_scenario.should == scenarios[1]
      statuses[1].mark_finished!
      assignment.next_scenario.should == scenarios[2]
      statuses[2].mark_finished!
      assignment.next_scenario.should be_nil
      assignment.should have(0).incomplete_scenarios
      assignment.reload
      assignment.should be_finished
    end

  end
end
