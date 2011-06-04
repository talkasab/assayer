class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :layout
  before_filter :authenticate_user!

  protected

  def check_assigned_to_current_user!
    if assignment.rater_id != current_user.id
      flash[:error] = "You are not assigned to this scenario."
      redirect_to assignments_path
    end
  end

end
