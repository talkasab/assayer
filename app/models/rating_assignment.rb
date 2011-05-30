class RatingAssignment < ActiveRecord::Base
  # Associations
  belongs_to :rater, :class_name => "User", :inverse_of => :assignments
  belongs_to :scenario_family, :inverse_of => :assignments

  # Validations
  validates_presence_of :rater, :scenario_family
  validates_uniqueness_of :rater_id, :scope => :scenario_family_id

  # Status Logic
  scope :finished, where("finished_at is not null")
  scope :not_finished, where("finished_at is null")
  scope :current, lambda { not_finished.where("(start_at is null OR start_at <= :now) AND (end_at is null OR end_at >= :now)", :now => Time.now) }
  scope :expired, lambda { not_finished.where("end_at < ?", Time.now) }
  scope :pending, lambda { not_finished.where("start_at > ?", Time.now) }

  def mark_finished!
    touch(:finished_at)
  end

  def finished?
    finished_at.present? && finished_at <= Time.now
  end

  def expired?
    ! finished? && end_at.present? && end_at < Time.now
  end

  def pending?
    ! finished? && start_at.present? && start_at > Time.now
  end

  def current?
    ! finished? && ! expired? && ! pending?
  end

  def status
    if finished?
      :finished
    elsif expired?
      :expired
    elsif pending?
      :pending
    else
      :current
    end
  end

  # Incomplete scenarios
  def incomplete_scenarios
    subselect = <<-SQLEND
      SELECT s.id FROM scenarios s, rater_scenario_statuses r
      WHERE r.scenario_id = s.id AND s.scenario_family_id = :scenario_family
      AND r.rater_id = :rater AND r.finished_at IS NOT NULL
    SQLEND
    scenario_family.scenarios.where("\"scenarios\".id NOT IN (#{subselect})", 
                                    :rater => rater_id, :scenario_family => scenario_family_id)
  end
end

