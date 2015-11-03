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

ActiveRecord::Schema.define(version: 20151103154843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "timeslots", force: :cascade do |t|
    t.datetime "start",      null: false
    t.integer  "tutor_id",   null: false
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "subject"
  end

  add_index "timeslots", ["start"], name: "index_timeslots_on_start", using: :btree
  add_index "timeslots", ["student_id"], name: "index_timeslots_on_student_id", using: :btree
  add_index "timeslots", ["tutor_id"], name: "index_timeslots_on_tutor_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uid"
    t.string   "image"
    t.string   "email"
  end

end
