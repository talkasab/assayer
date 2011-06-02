require 'spec_helper'

describe "assignments routing" do
  it "routes the root to assignments#index" do
    {:get => '/'}.should route_to("assignments#index")
  end

  it "knows the named routes" do
    {:get => assignments_path}.should route_to("assignments#index")
  end

  it "should not route unused actions" do
    {:get => '/assignments/new'}.should_not be_routable
    {:get => '/assignments/1'}.should_not be_routable
    {:post => '/assignments'}.should_not be_routable
    {:put => '/assignments/1'}.should_not be_routable
    {:get => '/assignments/1/edit'}.should_not be_routable
    {:delete => '/assignments/1'}.should_not be_routable
  end
end

# describe "scenarios routing" do
#   let!(:scenario) { Factory.create(:scenario) }
#   let!(:assignment) { Factory.create(:rating_assignment, :scenario_family => scenario.scenario_family) }
# 
#   it "routes :show and :next actions appropriately" do
#     get("/assignments/#{assignment.id}/scenarios/2").should route_to(:controller => :scenarios, :action => :show, :assignment_id => assignment.id.to_s)
#     get('/assignments/42/scenarios/next').should route_to(:controller => :scenarios, :action => :next, :assignment_id => '42')
#   end
# 
#   it "knows the named routes" do
#     # get(assignment_scenario_path(assignment, scenario)).should route_to("scenarios#show")
#   end
# end
