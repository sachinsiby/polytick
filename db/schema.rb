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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160416175410) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "candidates", force: :cascade do |t|
    t.string "name"
    t.string "party"
    t.string "image_url"
    t.text   "policies",  default: "[]"
    t.string "blob"
    t.string "subtitle"
  end

  create_table "poll_statistics", force: :cascade do |t|
    t.integer "poll_id"
    t.decimal "percentage"
    t.string  "candidate_name"
  end

  create_table "polls", force: :cascade do |t|
    t.string   "name"
    t.string   "poller"
    t.string   "state_name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "party"
  end

  create_table "result_statistics", force: :cascade do |t|
    t.integer "result_id"
    t.string  "candidate_name"
    t.decimal "percentage"
    t.integer "num_delegates"
  end

  create_table "results", force: :cascade do |t|
    t.string   "name",                 null: false
    t.string   "party",                null: false
    t.string   "state",                null: false
    t.datetime "date",                 null: false
    t.string   "delegates_allocated"
    t.decimal  "reporting_percentage"
  end

end
