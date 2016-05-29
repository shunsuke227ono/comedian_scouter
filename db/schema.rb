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

ActiveRecord::Schema.define(version: 20160529163157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "co_appears", force: :cascade do |t|
    t.integer  "count",         default: 0
    t.integer  "comedian_id_1",             null: false
    t.integer  "comedian_id_2",             null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "comedians", force: :cascade do |t|
    t.string   "name",                            null: false
    t.string   "img"
    t.string   "url"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "appear_count",        default: 0
    t.integer  "has_monthly_appears"
  end

  create_table "comedians_companies", force: :cascade do |t|
    t.integer  "comedian_id", null: false
    t.integer  "company_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monthly_appears", force: :cascade do |t|
    t.integer  "count",       default: 0
    t.integer  "comedian_id",             null: false
    t.date     "start_date",              null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "quoter_appears", force: :cascade do |t|
    t.integer  "count",       default: 0
    t.integer  "comedian_id",             null: false
    t.date     "start_date",              null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "weekly_tweets", force: :cascade do |t|
    t.integer  "comedian_id",             null: false
    t.integer  "count",       default: 0
    t.date     "start_date",              null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
