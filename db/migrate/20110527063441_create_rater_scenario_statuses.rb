class CreateRaterScenarioStatuses < ActiveRecord::Migration
  def self.up
    create_table :rater_scenario_statuses do |t|
      t.references :rater, :null => false
      t.references :scenario, :null => false
      t.timestamp :started_at
      t.timestamp :finished_at
      t.integer :items_completed, :null => false, :default => 0
      t.timestamps
    end
    add_index :rater_scenario_statuses, [:rater_id, :scenario_id], :unique => true
    add_index :rater_scenario_statuses, :scenario_id
  end

  def self.down
    drop_table :rater_scenario_statuses
  end
end
