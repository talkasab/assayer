require 'spec_helper'

describe AssignmentsController do

  describe "GET 'index'" do
    context "without being logged in" do
      it "should redirect to the login page" do
        get 'index'
        response.should redirect_to(new_user_session_path)
      end
    end

    context "with a successful login" do
      let!(:user) { Factory.create(:user) }
      before(:each) { sign_in user }

      it "should be successful" do
        get 'index'
        response.should be_success
        controller.current_user.should == user
      end
    end
  end

end
