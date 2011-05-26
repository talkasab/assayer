class ScenarioFamily < ActiveRecord::Base
  has_many :scenarios, :inverse_of => :scenario_family

  validates :name, :presence => true, :uniqueness => true
end
