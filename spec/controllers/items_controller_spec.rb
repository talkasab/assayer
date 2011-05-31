require 'spec_helper'

describe ItemsController do
  let!(:item) { Factory.create(:medical_record_item) }

  context "no logged in user" do
    it "show should redirect the show action" do
      get :show, :scenario_id => item.scenario, :id => item
      response.should redirect_to(new_user_session_path)
    end

    it "index should redirect the show action" do
      get :index, :scenario_id => item.scenario
      response.should redirect_to(new_user_session_path)
    end
  end

  context "a logged in user" do
    before(:each) { sign_in Factory.create(:user) }

    it "show should be successful" do
      get :show, :scenario_id => item.scenario, :id => item
      response.should be_success
    end

    it "index should be successful" do
      get :index, :scenario_id => item.scenario
      response.should be_success
    end
  end

end
