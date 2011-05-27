class ItemRating < ActiveRecord::Base
  # Associations
  belongs_to :item, :class_name => "MedicalRecordItem", :inverse_of => :ratings
  belongs_to :rater, :class_name => "User", :inverse_of => :ratings

  # Validations
  validates_presence_of :item, :rater, :rating
  validates_uniqueness_of :rater_id, :scope => :item_id
  validates_numericality_of :rating, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 3
end
