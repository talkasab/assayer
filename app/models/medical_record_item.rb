require File.join(Rails.root, 'lib', 'medical_record_item_type')
class MedicalRecordItem < ActiveRecord::Base
  # Associations
  belongs_to :scenario, :inverse_of => :items
  has_many :ratings, :class_name => "ItemRating", :foreign_key => :item_id, :inverse_of => :item

  # Validations
  validates_presence_of :scenario, :report
  validates :days_from_index, :presence => true, :numericality => { :only_integer => true }
  validates :item_type, :presence => true, :inclusion => { :in => Type::list }
  # NOTE: We validate inclusion of type, but we probably can't set an invalid type anyway

  # Scope
  scope :before_index_exam, where("days_from_index <= 0")
end
