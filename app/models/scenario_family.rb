class ScenarioFamily < ActiveRecord::Base
  has_many :scenarios

  validates :name, :presence => true, :uniqueness => true
end
