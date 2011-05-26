class MedicalRecordItem < ActiveRecord::Base
  # Associations
  belongs_to :scenario, :inverse_of => :items
  belongs_to :item_type, :class_name => "MedicalRecordItemType", :inverse_of => :medical_record_items

  # Validations
  validates_presence_of :scenario, :days_from_index, :item_type, :report
  validates_numericality_of :days_from_index, :only_integer => true
end
