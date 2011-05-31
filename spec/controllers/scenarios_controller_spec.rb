require 'spec_helper'

describe ScenariosController do
  let!(:scenario) { Factory.create(:scenario) }

  context "without a logged in user" do
    describe "GET 'show'" do
      it "should redirect" do
        get :show, :id => scenario
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  context "with a logged in user" do
    before(:each) { sign_in Factory.create(:user) }

    describe "GET 'show'" do
      it "should respond with success" do
        get :show, :id => scenario
        response.should be_success
      end
    end
  end

end
