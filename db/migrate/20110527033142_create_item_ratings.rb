class CreateItemRatings < ActiveRecord::Migration
  def self.up
    create_table :item_ratings do |t|
      t.references :item
      t.references :rater
      t.integer :rating
      t.timestamps
    end
    add_index :item_ratings, [:item_id, :rater_id], :unique => true
  end

  def self.down
    drop_table :item_ratings
  end
end
