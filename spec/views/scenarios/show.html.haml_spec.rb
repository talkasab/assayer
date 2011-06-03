require 'spec_helper'

describe "scenarios/show.html.haml" do
  let!(:rater) { Factory.create(:user) }
  let!(:assignment) { Factory.create(:rating_assignment, :rater => rater) }  
  let!(:scenario_family) { assignment.scenario_family }
  let!(:scenario) { Factory.create(:scenario, :scenario_family_id => scenario_family.id) }
  let!(:items) { (1..5).map { Factory.create(:medical_record_item, :scenario => scenario) } }
  let!(:current_item) { items[0] }
  let!(:item_rating) { ItemRating.new(:rater => rater, :item => current_item) }

  it "should have all of its elements" do
    view.stub(:current_user).and_return(rater)
    view.stub(:assignment).and_return(assignment)
    view.stub(:scenario_family).and_return(scenario_family)
    view.stub(:scenario).and_return(scenario)
    view.stub(:items).and_return(items)
    view.stub(:current_item).and_return(current_item)
    view.stub(:item_rating).and_return(item_rating)
    render

    rendered.should have_selector("#scenario_family_#{scenario_family.id}") 

    rendered.should have_selector("#scenario_#{scenario.id}")
    rendered.should have_selector("#scenario_#{scenario.id} .patient_info")
    rendered.should have_selector("#scenario_#{scenario.id} .exam_info")
    rendered.should have_selector("#scenario_#{scenario.id} .report")
    
    rendered.should have_selector("#item_list")
    rendered.should have_selector("#item_list .medical_record_item", :count => 5)
    rendered.should have_selector("#item_list #medical_record_item_#{items[2].id}")
    
    rendered.should have_selector("#current_item") 
    rendered.should have_selector("#current_item #item_info")
    rendered.should have_selector("#current_item #item_report")

    rendered.should have_selector("#current_item #item_rating_form") 
    rendered.should have_selector("#current_item #item_rating_form form#new_item_rating") 
  end

end
