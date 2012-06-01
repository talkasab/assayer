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

  def navbar_link(text, link)
    if current_page?(link)
      haml_tag :li, :class => "active" do
        haml_concat link_to(text, '#')
      end
    else
      haml_tag :li do
        haml_concat link_to(text, link)
      end
    end
  end

  # Create a named haml tag to wrap IE conditional around a block
  # http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither
  # Consider adding an manifest.appcache: h5bp.com/d/Offline
  def ie_tag(name=:body, attrs={}, &block)
    attrs.symbolize_keys!
    haml_concat("<!--[if lt IE 7]> #{ tag(name, add_class('ie6', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if IE 7]>    #{ tag(name, add_class('ie7', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if IE 8]>    #{ tag(name, add_class('ie8', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if gt IE 8]><!-->".html_safe)
    haml_tag name, attrs do
      haml_concat("<!--<![endif]-->".html_safe)
      block.call
    end
  end

  def ie_html(attrs={}, &block)
    ie_tag(:html, attrs, &block)
  end

  def ie_body(attrs={}, &block)
    ie_tag(:body, attrs, &block)
  end

  private
  def add_class(name, attrs)
    classes = attrs[:class] || ''
    classes.strip!
    classes = ' ' + classes if !classes.blank?
    classes = name + classes
    attrs.merge(:class => classes)
  end
end
