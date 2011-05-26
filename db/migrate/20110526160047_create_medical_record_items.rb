class CreateMedicalRecordItems < ActiveRecord::Migration
  def self.up
    create_table :medical_record_items do |t|
      t.references :scenario
      t.integer :days_from_index
      t.references :item_type
      t.string :description
      t.text :report
      t.timestamps
    end
    add_index :medical_record_items, :scenario_id
  end

  def self.down
    drop_table :medical_record_items
  end
end
