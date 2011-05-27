class ScenarioFamily < ActiveRecord::Base
  has_many :scenarios, :inverse_of => :scenario_family
  has_many :assignments, :class_name => "RatingAssignment", :inverse_of => :scenario_family
  has_many :raters, :through => :assignments

  validates :name, :presence => true, :uniqueness => true
end
