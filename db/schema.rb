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

ActiveRecord::Schema.define(version: 20150925073030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "av_libs", force: true do |t|
    t.string   "av_title"
    t.string   "av_type"
    t.string   "av_duration"
    t.string   "av_poster"
    t.string   "av_source"
    t.string   "av_introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channel_videos", force: true do |t|
    t.integer  "channel_id"
    t.string   "youku_id"
    t.integer  "is_recommend", default: 0
    t.integer  "video_type",   default: 0
    t.string   "title"
    t.text     "content"
    t.string   "video_cover"
    t.text     "youku_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "channel_videos", ["youku_id"], name: "index_channel_videos_on_youku_id", unique: true, using: :btree

  create_table "channels", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "english"
    t.string   "cover"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_details", force: true do |t|
    t.integer  "user_id"
    t.string   "avatar"
    t.string   "nick_name"
    t.string   "iphone"
    t.string   "qq"
    t.string   "web_style",  default: "sidebar-mini wysihtml5-supported skin-blue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "level",                  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "video_comments", force: true do |t|
    t.integer  "channel_video_id"
    t.integer  "user_id"
    t.integer  "reply_id"
    t.integer  "vote_count"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "video_comments", ["id"], name: "index_video_comments_on_id", using: :btree

end
