# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110527063441) do

  create_table "item_ratings", :force => true do |t|
    t.integer  "item_id",    :null => false
    t.integer  "rater_id",   :null => false
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_ratings", ["item_id", "rater_id"], :name => "index_item_ratings_on_item_id_and_rater_id", :unique => true

  create_table "medical_record_items", :force => true do |t|
    t.integer  "scenario_id",     :null => false
    t.integer  "days_from_index", :null => false
    t.string   "item_type",       :null => false
    t.string   "description"
    t.text     "report",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medical_record_items", ["scenario_id"], :name => "index_medical_record_items_on_scenario_id"

  create_table "rater_scenario_statuses", :force => true do |t|
    t.integer  "rater_id",                       :null => false
    t.integer  "scenario_id",                    :null => false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "items_completed", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rater_scenario_statuses", ["rater_id", "scenario_id"], :name => "index_rater_scenario_statuses_on_rater_id_and_scenario_id", :unique => true
  add_index "rater_scenario_statuses", ["scenario_id"], :name => "index_rater_scenario_statuses_on_scenario_id"

  create_table "rating_assignments", :force => true do |t|
    t.integer  "rater_id",           :null => false
    t.integer  "scenario_family_id", :null => false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_assignments", ["rater_id"], :name => "index_rating_assignments_on_rater_id"
  add_index "rating_assignments", ["scenario_family_id", "rater_id"], :name => "index_rating_assignments_on_scenario_family_id_and_rater_id", :unique => true

  create_table "scenario_families", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scenario_families", ["name"], :name => "index_scenario_families_on_name", :unique => true

  create_table "scenarios", :force => true do |t|
    t.integer  "scenario_family_id",    :null => false
    t.integer  "patient_age",           :null => false
    t.string   "patient_sex",           :null => false
    t.string   "exam_description",      :null => false
    t.text     "exam_clinical_history", :null => false
    t.text     "exam_comment"
    t.text     "exam_report",           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                                 :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
