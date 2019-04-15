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

ActiveRecord::Schema.define(version: 2019_04_15_230057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "driver_passengers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "driver_id"
    t.bigint "passenger_id"
    t.index ["driver_id"], name: "index_driver_passengers_on_driver_id"
    t.index ["passenger_id"], name: "index_driver_passengers_on_passenger_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.integer "vin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_drivers_on_trip_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.string "name"
    t.integer "phone_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_passengers_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.date "date"
    t.float "rating"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "driver_id"
    t.bigint "passenger_id"
    t.index ["driver_id"], name: "index_trips_on_driver_id"
    t.index ["passenger_id"], name: "index_trips_on_passenger_id"
  end

  add_foreign_key "driver_passengers", "drivers"
  add_foreign_key "driver_passengers", "passengers"
  add_foreign_key "drivers", "trips"
  add_foreign_key "passengers", "trips"
  add_foreign_key "trips", "drivers"
  add_foreign_key "trips", "passengers"
end
