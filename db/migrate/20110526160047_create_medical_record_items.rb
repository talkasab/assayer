class CreateMedicalRecordItems < ActiveRecord::Migration
  def self.up
    create_table :medical_record_items do |t|
      t.references :scenario, :null => false
      t.integer :days_from_index, :null => false
      t.string :item_type, :null => false
      t.string :description
      t.text :report, :null => false
      t.timestamps
    end
    add_index :medical_record_items, :scenario_id
  end

  def self.down
    drop_table :medical_record_items
  end
end
