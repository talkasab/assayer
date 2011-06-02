class ScenariosController < ApplicationController
  expose(:assignment) { RatingAssignment.find(params[:assignment_id]) }
  expose(:scenarios) { assignment.scenarios }
  expose(:scenario)
  expose(:scenario_status) { RaterScenarioStatus.find_or_create_by_rater_id_and_scenario_id(current_user, scenario) }

  before_filter :check_assigned_to_scenario

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
  def check_assigned_to_scenario
    logmark = log_mark("check_assigned_to_scenario")
    if assignment.rater_id == current_user.id
      logger.debug "#{logmark} User #{current_user.id} is the rater for this assignment: #{assignment.inspect}"
    else 
      logger.warn "#{logmark} User #{current_user.id} is not the rater for this assignment: #{assignment.inspect}"
      flash[:error] = "You are not assigned to this scenario."
      redirect_to assignments_path
    end
  end

  def redirect_to_next_scenario
    if ! assignment.finished? && assignment.next_scenario.present?
      redirect_to assignment_scenario_path(assignment, assignment.next_scenario)
    else
      flash[:notice] = "You have completed the #{assignment.scenario_family.name} assignment."
      redirect_to assignments_path
    end
  end

  def log_mark(method = nil)
    mark = self.class.to_s
    mark += '#' + method if method.present?
    Color.blue + mark + Color.clear
  end

end
