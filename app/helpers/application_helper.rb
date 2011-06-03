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
end
