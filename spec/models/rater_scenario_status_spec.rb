require 'spec_helper'

describe RaterScenarioStatus do
  let!(:status) { Factory.create(:rater_scenario_status) }

  # Associations
  it { should belong_to(:rater) }
  it { should belong_to(:scenario) }
  
  # Validations
  it { should validate_presence_of(:rater) }
  it { should validate_presence_of(:scenario) }
  it { should validate_uniqueness_of(:scenario_id).scoped_to(:rater_id) }

  # Status Logic
  it "should give :unstarted status if both timestamps are blank" do
    s = Factory.create(:rater_scenario_status, :started_at => nil, :finished_at => nil)
    s.status.should == :unstarted
  end

  it "should give :started status if :finished_at is blank" do
    s = Factory.create(:rater_scenario_status, :started_at => 1.day.ago, :finished_at => nil)
    s.status.should == :started
  end

  it "should give :finished status if :finished_at is blank" do
    s = Factory.create(:rater_scenario_status, :started_at => 1.day.ago, :finished_at => 1.hour.ago)
    s.status.should == :finished
  end

  it "should give correct status (and counts) over lifetime" do
    s = Factory.create(:rater_scenario_status)
    s.status.should == :unstarted
    expect {
      expect { s.mark_started! }.to change { RaterScenarioStatus.unstarted.count }.by(-1)
      s.status.should == :started
      expect { s.mark_finished! }.to change { RaterScenarioStatus.started.count }.by(-1)
      s.status.should == :finished
    }.to change{RaterScenarioStatus.finished.count}.by(+1)
  end

  it "should not update started_at unless it was unset" do
    old_time = 1.day.ago
    s = Factory.create(:rater_scenario_status, :started_at => old_time)
    s.status.should == :started
    s.mark_started!
    s.reload
    s.started_at.should == old_time
  end

  # Items to complete
  describe "Figuring out how many items remain to be completed" do
    let!(:scenario) { Factory.create(:scenario) }
    let!(:items) { (1..5).map { Factory.create(:medical_record_item, :scenario => scenario) } }
    let!(:user) { Factory.create(:user) }
    let!(:status) { Factory.create(:rater_scenario_status, :scenario => scenario, :rater => user) }

    it "should know how many items are incomplete" do
      status.incomplete_items.should have(5).items
      status.incomplete_items.should include(items[0])
      items[0].ratings.create(:rater => user, :rating => 1)
      status.incomplete_items.should have(4).items
      status.incomplete_items.should_not include(items[0])
      items[1].ratings.create(:rater => user, :rating => 2)
      status.incomplete_items.should have(3).items
    end

  end
end
