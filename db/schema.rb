# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121107162618) do

  create_table "email_templates", :force => true do |t|
    t.string   "subject"
    t.text     "style"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "submission_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "feedbacks", ["submission_id"], :name => "index_feedbacks_on_submission_id", :unique => true

  create_table "page_texts", :force => true do |t|
    t.string   "page"
    t.string   "title"
    t.string   "heading"
    t.text     "body"
    t.text     "body2"
    t.text     "eula_text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "page_texts", ["page"], :name => "index_page_texts_on_page", :unique => true

  create_table "submissions", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "location",   :default => "village"
    t.string   "token"
    t.integer  "visit_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "submissions", ["email"], :name => "index_submissions_on_email", :unique => true
  add_index "submissions", ["location"], :name => "index_submissions_on_location"
  add_index "submissions", ["name"], :name => "index_submissions_on_name"
  add_index "submissions", ["token"], :name => "index_submissions_on_token", :unique => true

  create_table "visits", :force => true do |t|
    t.string   "user_agent"
    t.string   "operative_system"
    t.string   "os_version"
    t.string   "ip_address"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "visits", ["ip_address"], :name => "index_visits_on_ip_address"
  add_index "visits", ["operative_system"], :name => "index_visits_on_operative_system"
  add_index "visits", ["os_version"], :name => "index_visits_on_os_version"
  add_index "visits", ["user_agent"], :name => "index_visits_on_user_agent"

end
