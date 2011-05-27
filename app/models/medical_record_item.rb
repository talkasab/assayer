class MedicalRecordItem < ActiveRecord::Base
  # Associations
  belongs_to :scenario, :inverse_of => :items
  belongs_to :item_type, :class_name => "MedicalRecordItemType", :inverse_of => :medical_record_items
  has_many :ratings, :class_name => "ItemRating", :foreign_key => :item_id, :inverse_of => :item

  # Validations
  validates_presence_of :scenario, :days_from_index, :item_type, :report
  validates_numericality_of :days_from_index, :only_integer => true
end
