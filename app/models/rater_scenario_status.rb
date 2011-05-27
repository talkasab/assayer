class RaterScenarioStatus < ActiveRecord::Base
  # Associations
  belongs_to :rater, :class_name => "User", :inverse_of => :scenario_statuses
  belongs_to :scenario, :inverse_of => :rater_statuses

  # Validations
  validates_presence_of :rater, :scenario, :items_completed
  validates_numericality_of :items_completed, :only_integer => true, :greater_than_or_equal_to => 0
  validates_uniqueness_of :scenario_id, :scope => :rater_id
end
