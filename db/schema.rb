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

ActiveRecord::Schema[7.0].define(version: 2023_10_28_173920) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "albums", force: :cascade do |t|
    t.string "title"
    t.integer "parent_album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_album_id"], name: "index_albums_on_parent_album_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "session_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "spot"
    t.index ["session_id"], name: "index_bookings_on_session_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "coaches", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cooking_steps", force: :cascade do |t|
    t.string "title"
    t.integer "number"
    t.text "description"
    t.integer "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_cooking_steps_on_recipe_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "title"
    t.integer "quantity"
    t.string "unity"
    t.integer "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "author_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_messages_on_author_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "title"
    t.integer "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_photos_on_album_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "cooking_time"
    t.string "title"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "draft_step"
  end

  create_table "round_table_events", force: :cascade do |t|
    t.string "name"
    t.integer "rounds_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "round_table_matchups", force: :cascade do |t|
    t.bigint "first_team_id"
    t.bigint "second_team_id"
    t.bigint "event_id"
    t.integer "round_number"
    t.string "workshop_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_round_table_matchups_on_event_id"
    t.index ["first_team_id"], name: "index_round_table_matchups_on_first_team_id"
    t.index ["second_team_id"], name: "index_round_table_matchups_on_second_team_id"
  end

  create_table "round_table_teams", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_round_table_teams_on_event_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "hub"
    t.string "sport"
    t.datetime "starts_at"
    t.bigint "episod_id"
    t.bigint "coach_id"
    t.integer "duration"
    t.jsonb "available_spots"
    t.integer "spots_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_id"], name: "index_sessions_on_coach_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "one_signal_player_id"
    t.text "episod_cookie"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
