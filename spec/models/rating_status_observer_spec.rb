require 'spec_helper'

describe RatingStatusObserver do
  let!(:scenario) { Factory.create(:scenario) }
  let!(:item) { Factory.create(:medical_record_item, :scenario => scenario) }
  let!(:item2) { Factory.create(:medical_record_item, :scenario => scenario) }
  let!(:user) { Factory.create(:user) }

  specify { scenario.should have(2).items }

  it "should create and update a status as started when a rating is created" do
    expect { rating = item.ratings.create(:rater => user, :rating => 1) }.to change { RaterScenarioStatus.count }.by(+1)
    status = RaterScenarioStatus.find_by_scenario_id_and_rater_id(scenario, user)
    status.status.should == :started
  end

  it "should just update a status if there was already one there" do
    status = Factory.create(:rater_scenario_status, :rater => user, :scenario => scenario)
    expect { item.ratings.create(:rater => user, :rating => 2) }.to change { RaterScenarioStatus.count }.by(0)
  end

  it "should mark the status as finished when the last item is done" do
    status = Factory.create(:rater_scenario_status, :rater => user, :scenario => scenario)
    item.ratings.create(:rater => user, :rating => 2)
    status.reload
    status.status.should == :started
    item2.ratings.create(:rater => user, :rating => 1)
    status.reload
    status.status.should == :finished
  end
end
