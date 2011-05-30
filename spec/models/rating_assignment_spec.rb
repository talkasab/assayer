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

  # Current/expired/pending logic
  it "should be current (not pending) with blank start_at" do
    rating = Factory.create(:rating_assignment, :start_at => nil)
    rating.status.should == :current
    rating.should be_current
    rating.should_not be_pending
    RatingAssignment.current.all.should include(rating)
    RatingAssignment.pending.all.should_not include(rating)
  end

  it "should be pending with a future start_at date" do
    rating = Factory.create(:rating_assignment, :start_at => 1.day.since)
    rating.status.should == :pending
    rating.should_not be_current
    rating.should be_pending
    RatingAssignment.current.all.should_not include(rating)
    RatingAssignment.pending.all.should include(rating)
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
end

