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

ActiveRecord::Schema.define(:version => 20110526160047) do

  create_table "exam_types", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exam_types", ["name"], :name => "index_exam_types_on_name", :unique => true

  create_table "medical_record_item_types", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medical_record_item_types", ["name"], :name => "index_medical_record_item_types_on_name", :unique => true

  create_table "medical_record_items", :force => true do |t|
    t.integer  "scenario_id"
    t.integer  "days_from_index"
    t.integer  "item_type_id"
    t.string   "description"
    t.text     "report"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medical_record_items", ["scenario_id"], :name => "index_medical_record_items_on_scenario_id"

  create_table "scenario_families", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scenario_families", ["name"], :name => "index_scenario_families_on_name", :unique => true

  create_table "scenarios", :force => true do |t|
    t.integer  "scenario_family_id",          :null => false
    t.integer  "patient_age",                 :null => false
    t.string   "patient_sex",                 :null => false
    t.integer  "index_exam_type_id",          :null => false
    t.text     "index_exam_clinical_history", :null => false
    t.text     "index_exam_comment"
    t.text     "index_exam_report",           :null => false
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
