# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_05_152214) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_consumers", id: :serial, force: :cascade do |t|
    t.string "public_api_key"
    t.string "private_api_key"
    t.string "contact_email", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "caption"
  end

  create_table "measurements", id: :serial, force: :cascade do |t|
    t.float "temperature", null: false
    t.json "custom_attributes"
    t.integer "sensor_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["created_at"], name: "index_measurements_on_created_at"
    t.index ["sensor_id"], name: "index_measurements_on_sensor_id"
  end

  create_table "sensors", id: :serial, force: :cascade do |t|
    t.string "device_name", null: false
    t.string "caption", null: false
    t.integer "sponsor_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.bigint "waterbody_id"
    t.index ["sponsor_id"], name: "index_sensors_on_sponsor_id"
    t.index ["waterbody_id"], name: "index_sensors_on_waterbody_id"
  end

  create_table "sponsors", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "logo_source", comment: "filename (in ./public/images/), relative path or URL"
  end

  create_table "waterbodies", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "measurements", "sensors"
  add_foreign_key "sensors", "waterbodies"
end
