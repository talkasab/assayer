require 'spec_helper'

describe ItemRatingsController do
  setup_assayer_objects(1,3)
  let!(:def_params) { {:assignment_id => assignment, :scenario_id => scenario, :item_id => item} }
  before(:each) { sign_in user }

  describe "GET 'new'" do
    before(:each) { get 'new', def_params }

    specify { response.should be_success }
    it "should have the right exposures" do
      controller.item_rating.should be_a_new(ItemRating)
      controller.assignment.should == assignment
      controller.scenario.should == scenario
      controller.item.should == item
    end
  end

  describe "GET 'edit'" do
    let!(:rating) { Factory.create(:item_rating, :item => item, :rater => user) }
    before(:each) { get 'edit', def_params.merge(:id => rating.id) }

    specify { response.should be_success }
    it "should have the right exposures" do
      controller.item_rating.should == rating
      controller.assignment.should == assignment
      controller.scenario.should == scenario
      controller.item.should == item
    end
  end

  describe "GET 'edit' of another users's rating" do
    let!(:rating) { Factory.create(:item_rating, :item => item, :rater => Factory.create(:user)) }
    before(:each) { get 'edit', def_params.merge(:id => rating) }

    it "should fail to find the object" do
      expect { controller.item_rating }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST 'create' successful" do
    before(:each) { post 'create', def_params.merge(:item_rating => { :rating => 2 }) }
    specify { response.should redirect_to(assignment_scenario_path(assignment, scenario)) }
    specify { flash[:error].should be_nil }
    it "should have a newly saved ItemRating" do
      controller.item_rating.should be_a_kind_of(ItemRating)
      controller.item_rating.id.should_not be_nil
    end
    it "should have the right exposures to ancillary objects" do
      controller.assignment.should == assignment
      controller.scenario.should == scenario
      controller.item.should == item
    end
  end

  describe "POST 'create' with error" do
    before(:each) { post 'create', def_params.merge(:item_rating => { :rating => 'nonsense' }) }
    specify { response.should redirect_to(assignment_scenario_path(assignment, scenario, :current_item_id => item.id)) }
    specify { flash[:error].should match(/could not save/i) }
  end

  describe "PUT 'update'" do
    let!(:rating) { item.ratings.create(:rater => user, :rating => 3) }
    before(:each) { put 'update', def_params.merge(:id => rating.id, :item_rating => { :rating => 1 }) }
    specify { response.should redirect_to(assignment_scenario_path(assignment, scenario)) }
    it("should have reset the arting") do
      rating.reload
      rating.rating.should == 1
    end
  end
end
