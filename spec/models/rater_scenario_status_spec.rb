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
end
