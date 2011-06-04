class ItemRating < ActiveRecord::Base
  RATINGS = ["Irrelevant", "Unlikely relevant", "Probably relevant", "Certainly relevant"]

  # Associations
  belongs_to :item, :class_name => "MedicalRecordItem", :inverse_of => :ratings
  belongs_to :rater, :class_name => "User", :inverse_of => :ratings

  # Validations
  validates_presence_of :item, :rater
  validates :rater_id, :presence => true, :uniqueness => { :scope => :item_id }
  validates :rating, :presence => true, 
    :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => RATINGS.length }
end
