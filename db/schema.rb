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

ActiveRecord::Schema.define(:version => 20110322151747) do

  create_table "cities", :force => true do |t|
    t.string  "title",         :null => false
    t.integer "department_id", :null => false
  end

  create_table "departments", :force => true do |t|
    t.string  "title",                     :null => false
    t.integer "country_id", :default => 1, :null => false
  end

  create_table "prices", :force => true do |t|
    t.boolean  "trusted",       :default => false
    t.float    "attestation"
    t.float    "course_work"
    t.float    "score_3"
    t.float    "score_4"
    t.float    "score_5"
    t.float    "test"
    t.integer  "university_id",                    :null => false
    t.integer  "user_id",                          :null => false
    t.string   "lesson",                           :null => false
    t.string   "teacher_id",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "university_id",                :null => false
    t.integer  "kind",          :default => 0
    t.integer  "user_id",                      :null => false
    t.string   "text",                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", :force => true do |t|
    t.integer  "university_id", :null => false
    t.string   "personal",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "universities", :force => true do |t|
    t.string   "short",             :null => false
    t.string   "title",             :null => false
    t.integer  "city_id",           :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
