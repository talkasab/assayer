class ScenariosController < ApplicationController
  expose(:assignment) { RatingAssignment.find(params[:assignment_id]) }
  expose(:scenarios) { assignment.scenarios }
  expose(:scenario) { assignment.scenarios.find(params[:id], :include => [:scenario_family, :items]) }
  expose(:items) { scenario.items }
  expose(:scenario_family) { scenario.scenario_family }
  expose(:scenario_status) { RaterScenarioStatus.find_or_create_by_rater_id_and_scenario_id(current_user.id, scenario.id) }
  expose(:current_item) { scenario_status.incomplete_items.first }
  expose(:item_rating) { ItemRating.new(:rater => current_user, :item => current_item) }

  before_filter :check_assigned_to_current_user!

  def show
    if scenario_status.finished?
      flash[:notice] = "Patient scenario completed."
      redirect_to_next_scenario
    end
  end

  def next
    redirect_to_next_scenario
  end

  protected
  def redirect_to_next_scenario
    if ! assignment.finished? && assignment.next_scenario.present?
      redirect_to assignment_scenario_path(assignment, assignment.next_scenario)
    else
      flash[:notice] = "You have completed the #{assignment.scenario_family.name} assignment."
      redirect_to assignments_path
    end
  end
end
