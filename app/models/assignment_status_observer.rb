class AssignmentStatusObserver < ActiveRecord::Observer
  observe :rater_scenario_status

  def logger; Rails.logger; end

  def after_save(status)
    logger.warn "For #{status.scenario.inspect} and #{status.rater.inspect}, determining whether to mark finished."
    assignment = RatingAssignment.find_by_scenario_family_id_and_rater_id(status.scenario.scenario_family_id, status.rater_id)
    if assignment
      count = assignment.incomplete_scenarios.count
      logger.warn "Found assignment (#{assignment.id}); has #{count} incomplete scenarios."
      assignment.mark_finished! if count == 0
    else
      logger.warn "Did not detected an assignment for family #{status.scenario.scenario_family_id}, rater #{status.rater_id}"
    end
  end
end
