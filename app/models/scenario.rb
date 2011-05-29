class Scenario < ActiveRecord::Base
  # Relationships
  belongs_to :scenario_family, :inverse_of => :scenarios
  has_many :items, :class_name => "MedicalRecordItem", :inverse_of => :scenario
  has_many :rater_statuses, :class_name => "RaterScenarioStatus", :inverse_of => :scenario
  has_many :raters, :through => :rater_statuses

  # Validations
  validates :scenario_family, :presence => true
  validates :patient_age, :presence => true, 
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 150 }
  validates :patient_sex, :presence => true, :inclusion => { :in => %w(M F) }
  validates_presence_of :exam_description, :exam_clinical_history, :exam_report
end
