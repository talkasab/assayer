class CreateRatingAssignments < ActiveRecord::Migration
  def self.up
    create_table :rating_assignments do |t|
      t.references :rater, :null => false
      t.references :scenario_family, :null => false
      t.timestamp :start_at
      t.timestamp :end_at
      t.timestamp :finished_at
      t.timestamps
    end
    add_index :rating_assignments, [:scenario_family_id, :rater_id], :unique => true
    add_index :rating_assignments, :rater_id
  end

  def self.down
    drop_table :rating_assignments
  end
end
