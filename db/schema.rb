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

ActiveRecord::Schema.define(version: 2018_06_18_203010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_consumers", id: :serial, force: :cascade do |t|
    t.string "public_api_key"
    t.string "private_api_key"
    t.string "contact_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "caption"
  end

  create_table "measurements", id: :serial, force: :cascade do |t|
    t.decimal "temperature", null: false
    t.json "custom_attributes"
    t.integer "sensor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sensor_id"], name: "index_measurements_on_sensor_id"
  end

  create_table "sensors", id: :serial, force: :cascade do |t|
    t.string "device_name", null: false
    t.string "caption", default: "", null: false
    t.integer "sponsor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["sponsor_id"], name: "index_sensors_on_sponsor_id"
  end

  create_table "sponsors", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
