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

ActiveRecord::Schema.define(version: 20150707231311) do

  create_table "components", force: :cascade do |t|
    t.string   "issuekey"
    t.string   "component"
    t.time     "hoursintriage"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "day_data", force: :cascade do |t|
    t.datetime "day"
    t.text     "componenthash"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "jiras", force: :cascade do |t|
    t.string   "issuekey"
    t.string   "projectname"
    t.string   "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "hoursintriage"
    t.date     "todaysdate"
  end

  create_table "managerdets", force: :cascade do |t|
    t.string   "component"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "link"
  end

  create_table "weeklydata", force: :cascade do |t|
    t.string   "WeekNumber"
    t.string   "Component"
    t.integer  "Avghours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
