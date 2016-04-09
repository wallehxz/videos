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

ActiveRecord::Schema.define(version: 20160409080640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "columns", force: :cascade do |t|
    t.string   "name"
    t.string   "english"
    t.string   "icon"
    t.string   "cover"
    t.text     "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "video_id"
    t.integer  "reply_id"
    t.integer  "vote"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                                           null: false
    t.string   "encrypted_password",     default: "",                                           null: false
    t.string   "nick_name"
    t.string   "avatar"
    t.string   "phone"
    t.string   "role",                   default: "looker"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                                            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "web_style",              default: "sidebar-mini wysihtml5-supported skin-blue"
    t.datetime "created_at",                                                                    null: false
    t.datetime "updated_at",                                                                    null: false
    t.string   "location"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.integer  "column_id"
    t.integer  "recommend",  default: 0
    t.integer  "video_type"
    t.string   "tv_code",                null: false
    t.string   "title"
    t.string   "cover"
    t.string   "duration"
    t.text     "summary"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "videos", ["tv_code"], name: "index_videos_on_tv_code", unique: true, using: :btree

end
