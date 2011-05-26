class CreateExamTypes < ActiveRecord::Migration
  def self.up
    create_table :exam_types do |t|
      t.string :name, :null => false
      t.text :description
      t.timestamps
    end
    add_index :exam_types, :name, :unique => true
  end

  def self.down
    drop_table :exam_types
  end
end
