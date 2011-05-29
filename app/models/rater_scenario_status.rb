class RaterScenarioStatus < ActiveRecord::Base
  # Associations
  belongs_to :rater, :class_name => "User", :inverse_of => :scenario_statuses
  belongs_to :scenario, :inverse_of => :rater_statuses

  # Validations
  validates_presence_of :rater, :scenario
  validates_uniqueness_of :scenario_id, :scope => :rater_id

  # Scopes
  scope :unstarted, where(:started_at => nil, :finished_at => nil)
  scope :started, where("started_at is not null and finished_at is null")
  scope :finished, where("finished_at is not null")

  # Status logic
  def status
    if finished_at.present?
      :finished
    elsif started_at.present?
      :started
    else
      :unstarted
    end
  end

  def mark_started!
    self.started_at = Time.now
    save!
  end

  def mark_finished!
    self.finished_at = Time.now
    save!
  end
end
