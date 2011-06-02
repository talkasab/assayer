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
      flash[:error] = "You are not assigned to this scenario."
      redirect_to assignments_path
    end
  end

end
