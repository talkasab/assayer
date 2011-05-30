class RatingStatusObserver < ActiveRecord::Observer
  observe :item_rating

  def after_create(rating)
    stat = RaterScenarioStatus.find_or_create_by_scenario_id_and_rater_id(rating.item.scenario, rating.rater)
    if stat.incomplete_items.count == 0
      stat.mark_finished!
    else
      stat.mark_started!
    end
  end
end
