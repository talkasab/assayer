module ApplicationHelper
  def days_from_to_text(days)
    if days == 0
      "Same day"
    elsif days > 0
      "#{pluralize(days, 'day')} after"
    else
      days = -days
      "#{pluralize(days, 'day')} prior"
    end
  end

  def item_rating_form_params(item_rating)
    item = item_rating.item || current_item || item
    if item_rating.new_record?
      { :url => assignment_scenario_item_item_ratings_path(assignment, scenario, item), :method => :post }
    else
      { :url => assignment_scenario_item_item_rating_path(assignment, scenario, item, item_rating), :method => :put }
    end
  end
end
