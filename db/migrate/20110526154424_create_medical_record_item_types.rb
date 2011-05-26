class CreateMedicalRecordItemTypes < ActiveRecord::Migration
  def self.up
    create_table :medical_record_item_types do |t|
      t.string :name, :null => false
      t.text :description
      t.timestamps
    end
    add_index :medical_record_item_types, :name, :unique => true
  end

  def self.down
    drop_table :medical_record_item_types
  end
end
