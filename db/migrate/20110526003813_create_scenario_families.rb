class CreateScenarioFamilies < ActiveRecord::Migration
  def self.up
    create_table :scenario_families do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    add_index :scenario_families, :name, :unique => true
  end

  def self.down
    drop_table :scenario_families
  end
end
