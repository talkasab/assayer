class ScenariosController < ApplicationController
  expose(:assignment) { RatingAssignment.find(params[:assignment_id]) }
  expose(:scenarios) { assignment.scenarios }
  expose(:scenario)

  before_filter :check_assigned_to_scenario

  def show
  end

  protected
  def check_assigned_to_scenario
    unless RatingAssignment.user_assigned_to_scenario?(current_user, scenario)
    logmark = log_mark("check_assigned_to_scenario")
      logger.debug "#{logmark} User #{current_user.id} is the rater for this assignment: #{assignment.inspect}"
      logger.warn "#{logmark} User #{current_user.id} is not the rater for this assignment: #{assignment.inspect}"
      flash[:error] = "You are not assigned to this scenario."
      redirect_to assignments_path
    end
  end


  def log_mark(method = nil)
    mark = self.class.to_s
    mark += '#' + method if method.present?
    Color.blue + mark + Color.clear
  end

end
