class RaterScenarioStatus < ActiveRecord::Base
  # Associations
  belongs_to :rater, :class_name => "User", :inverse_of => :scenario_statuses
  belongs_to :scenario, :inverse_of => :rater_statuses

  # Validations
  validates_presence_of :rater, :scenario
  validates_uniqueness_of :scenario_id, :scope => :rater_id

  # Status logic
  scope :unstarted, where(:started_at => nil, :finished_at => nil)
  scope :started, where("started_at is not null and finished_at is null")
  scope :finished, where("finished_at is not null")

  def status
    if finished_at.present?
      :finished
    elsif started_at.present?
      :started
    else
      :unstarted
    end
  end
  
  def unstarted?; status == :unstarted; end
  def started?; status == :started; end
  def finished?; status == :finished; end

  def mark_started!
    update_attributes(:started_at => Time.now) if started_at.blank?
  end

  def mark_finished!
    update_attributes(:finished_at => Time.now) if finished_at.blank?
  end

  # Items to complete
  def incomplete_items(reload = false)
    subselect = <<-SQLEND
      select r.item_id from item_ratings r, medical_record_items m 
      where r.rater_id=? and r.item_id = m.id and m.scenario_id=?
    SQLEND
    scenario.items(reload).where("id not in (#{subselect})", rater.id, scenario.id)
  end

end
