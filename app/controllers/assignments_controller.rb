class AssignmentsController < ApplicationController

  expose(:assignments) { current_user.assignments.current }

  def index
  end
end
