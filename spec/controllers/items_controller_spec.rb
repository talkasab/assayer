require 'spec_helper'

describe ItemsController do
  let!(:item) { Factory.create(:medical_record_item) }

  context "no logged in user" do
    it "should redirect the show action" do
      get :show, :scenario_id => item.scenario, :id => item
      response.should redirect_to(new_user_session_path)
    end
  end

  context "a logged in user" do
    before(:each) { sign_in Factory.create(:user) }

    it "should be successful" do
      get :show, :scenario_id => item.scenario, :id => item
      response.should be_success
    end
  end

end
