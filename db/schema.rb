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

ActiveRecord::Schema.define(version: 20161128042902) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "picture_id", limit: 4
    t.integer  "rank",       limit: 4
    t.text     "comment",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "season",     limit: 255
    t.integer  "month",      limit: 4
    t.string   "time",       limit: 255
    t.string   "theme",      limit: 255
    t.text     "comment",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "location",   limit: 65535
    t.integer  "ave_rank",   limit: 4
    t.string   "picture",    limit: 255
  end

  create_table "places", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "picture_id",  limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "name",                   limit: 255
    t.string   "sex",                    limit: 255
    t.text     "mail",                   limit: 65535
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
