require 'spec_helper'

describe 'assignments/index.html.haml' do
  let!(:user) { Factory.create(:user) }
  let!(:assignments) { (1..3).map { Factory.create(:rating_assignment, :rater => user) } }

  it "should show the exposed assignments" do
    view.should_receive(:assignments).at_least(:once).and_return(assignments)
    render
    3.times do |n|
      rendered.should have_selector("tr#rating_assignment_#{assignments[n].id}") do |row|
        row.should have_link("Next Item", :href => next_assignment_scenarios_path(assignments[n]))
      end
    end
  end

  it "should say no assignments when there are no assignments" do
    view.should_receive(:assignments).at_least(:once).and_return([])
    render
    rendered.should have_selector("div.no_assignments")
  end
end
