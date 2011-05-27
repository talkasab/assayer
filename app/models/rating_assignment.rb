class RatingAssignment < ActiveRecord::Base
  # Associations
  belongs_to :rater, :class_name => "User", :inverse_of => :assignments
  belongs_to :scenario_family, :inverse_of => :assignments

  # Validations
  validates_presence_of :rater, :scenario_family
  validates_uniqueness_of :rater_id, :scope => :scenario_family_id

  # Scopes
  scope :current, lambda { where("(start_at is null OR start_at <= :now) AND (end_at is null OR end_at >= :now)", :now => Time.now) }
  scope :expired, lambda { where("end_at < ?", Time.now) }
  scope :pending, lambda { where("start_at > ?", Time.now) }

  def expired?
    end_at.present? && end_at < Time.now
  end

  def pending?
    start_at.present? && start_at > Time.now
  end

  def current?
    ! expired? && ! pending?
  end
end

