class CreateScenarios < ActiveRecord::Migration
  def self.up
    create_table :scenarios do |t|
      t.references :scenario_family, :null => false
      t.integer :patient_age, :null => false
      t.string :patient_sex, :null => false
      t.string :exam_description, :null => false
      t.text :exam_clinical_history, :null => false
      t.text :exam_comment
      t.text :exam_report, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :scenarios
  end
end
