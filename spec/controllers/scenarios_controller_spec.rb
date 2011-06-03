require 'spec_helper'

describe ScenariosController do
  let!(:scenario) { Factory.create(:scenario) }

  context "without a logged in user" do
    describe "GET 'show'" do
      it "should redirect" do
        get :show, :assignment_id => 42, :id => scenario
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  context "with a logged in user" do
    let!(:user) { Factory.create(:user) }
    let!(:assignment) { Factory.create(:rating_assignment, :rater => user) }
    let!(:scenarios) { (1..3).map { Factory.create(:scenario, :scenario_family => assignment.scenario_family) } }
    let!(:items) { (1..5).map { Factory.create(:medical_record_item, :scenario => scenarios.first) } }
    
    before(:each) do
      sign_in user
    end

    context "and his own assignment" do
      before(:each) { get :show, :assignment_id => assignment, :id => scenarios.first }

      specify { response.should be_success }
      its(:assignment) { should == assignment }
      it { should have(3).scenarios }
      its(:scenario) { should == scenarios.first }
      its(:scenario_family) { should == assignment.scenario_family }
      it "should have a correct scenario status" do
        status = controller.scenario_status
        status.rater.should == user
        status.scenario.should == scenarios[0]
      end
      its(:items) { should == items }
      its(:current_item) { should == items.first }
    end

    context "logged in as a user not assigned to the scenario" do
      let!(:another_user) { Factory.create(:user) }
      let!(:another_assignment) { Factory.create(:rating_assignment, :rater => another_user) }
      let!(:other_scenarios) { (1..3).map { Factory.create(:scenario, :scenario_family => another_assignment.scenario_family) } }
      before(:each) { get :show, :assignment_id => another_assignment, :id => other_scenarios.first }
      it "should redirect" do
        response.should redirect_to(assignments_path)
        flash[:error].should =~ /not assigned/
      end
    end

    context "when the scenario is finished" do
      before(:each) do
        RaterScenarioStatus.create(:scenario => scenarios.first, :rater => user, :finished_at => Time.now) 
        get :show, :assignment_id => assignment, :id => scenarios.first  
      end

      its(:scenario) { should == scenarios.first }
      it "should redirect to the next scenario" do
        response.should redirect_to(assignment_scenario_path(assignment, scenarios[1]))
      end
    end

    context "when the assignment as been finished" do
      before(:each) do
        3.times { |n| RaterScenarioStatus.create(:scenario => scenarios[n], :rater => user, :finished_at => Time.now) }
        get :show, :assignment_id => assignment, :id => scenarios.first
      end
      it "should redirect to the assignments index" do
        response.should redirect_to(assignments_path)
      end
    end
  end
end
