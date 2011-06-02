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
    let!(:assignment) { Factory.create(:rating_assignment) }
    let!(:scenarios) { (1..3).map { Factory.create(:scenario, :scenario_family => assignment.scenario_family)} }
    
    before(:each) do
      sign_in user
      RatingAssignment.stub(:user_assigned_to_scenario?).and_return(true)
      get :show, :assignment_id => assignment, :id => scenarios[0]
    end

    specify { response.should be_success }
    its(:assignment) { should == assignment }
    it { should have(3).scenarios }
    its(:scenario) { should == scenarios[0] }

    context "logged in as a user not assigned to the scenario" do
      let!(:another_user) { Factory.create(:user) }
      it "should redirect" do
        RatingAssignment.stub(:user_assigned_to_scenario?).and_return(false)
        get :show, :assignment_id => assignment, :id => scenarios[0]
        response.should redirect_to(assignments_path)
        flash[:error].should =~ /not assigned/
      end
    end

  end


end
