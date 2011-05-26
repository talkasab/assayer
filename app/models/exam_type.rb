class ExamType < ActiveRecord::Base
  # Assocations
  has_many :scenarios, :foreign_key => :index_exam_type_id, :inverse_of => :index_exam_type

  # Validations
  validates :name, :presence => true, :uniqueness => true
end
