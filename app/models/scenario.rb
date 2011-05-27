class Scenario < ActiveRecord::Base
  # Relationships
  belongs_to :scenario_family, :inverse_of => :scenarios
  has_many :items, :class_name => "MedicalRecordItem", :inverse_of => :scenario
  has_many :rater_statuses, :class_name => "RaterScenarioStatus", :inverse_of => :scenario
  has_many :raters, :through => :rater_statuses

  # Validations
  validates_presence_of :scenario_family
  validates_presence_of :patient_age
  validates_numericality_of :patient_age, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 150
  validates_presence_of :patient_sex
  validates_inclusion_of :patient_sex, :in => %w(M F)
  validates_presence_of :index_exam_clinical_history
  validates_presence_of :index_exam_report
end
