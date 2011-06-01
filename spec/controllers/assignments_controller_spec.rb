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
      before(:each) do
        sign_in user 
        get 'index'
      end

      its(:current_user) { should == user }
      specify { response.should be_success }
      it { should have(3).assignments }
    end
  end

end
