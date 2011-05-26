class MedicalRecordItemType < ActiveRecord::Base
  # Associations
  has_many :medical_record_items, :foreign_key => :item_type_id, :inverse_of => :item_type

  # Validations
  validates :name, :presence => true, :uniqueness => true
end
