class AssignmentsController < ApplicationController

  expose(:assignments) { current_user.assignments }

  def index
  end
end
