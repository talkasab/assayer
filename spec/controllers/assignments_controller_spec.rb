require 'spec_helper'

describe AssignmentsController do

  context "without being logged in" do
    its(:current_user) { should be_nil }

    it "index should redirect to the login page" do
      get 'index'
      response.should redirect_to(new_user_session_path)
    end
  end

  describe "GET 'index'" do

    context "with a valid login" do
      let!(:user) { Factory.create(:user) }
      let!(:assignments) { (1..3).map { Factory.create :rating_assignment, :rater => user } }
      let!(:another_user) { Factory.create(:user) }
      let!(:another_user_assignments) { (1..2).map { Factory.create :rating_assignment, :rater => another_user } }

      before(:each) do
        sign_in user 
        get 'index'
      end

      its(:current_user) { should == user }
      specify { response.should be_success }
      it { should have(3).assignments }
      its(:assignments) { should include(assignments[0]) }
      its(:assignments) { should_not include(another_user_assignments[1]) }

      it "should not include expired assignment" do
        expired = Factory.create(:rating_assignment, :rater => user, :end_at => DateTime.yesterday)
        controller.assignments.should_not include(expired)
      end

      it "should not include pending assignment" do
        future = Factory.create(:rating_assignment, :rater => user, :start_at => DateTime.tomorrow)
        controller.assignments.should_not include(future)
      end

      it "should not include finished assignment" do
        finished = Factory.create(:rating_assignment, :rater => user, :finished_at => DateTime.yesterday)
        controller.assignments.should_not include(finished)
      end
    end
  end

end

