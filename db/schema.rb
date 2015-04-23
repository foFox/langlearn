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

ActiveRecord::Schema.define(version: 20150423051650) do

  create_table "conversations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",         limit: 4
    t.integer  "conversation_id", limit: 4
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "session_tokens", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "token_string", limit: 255
    t.integer  "user_id",      limit: 4
    t.date     "last_seen"
  end

  add_index "session_tokens", ["token_string"], name: "index_session_tokens_on_token_string", using: :btree
  add_index "session_tokens", ["user_id"], name: "index_session_tokens_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",          limit: 255
    t.string   "surname",       limit: 255
    t.string   "email_address", limit: 255
    t.string   "password_hash", limit: 255
    t.string   "hash_salt",     limit: 255
    t.string   "user_type",     limit: 7
  end

  create_table "users_languages", force: :cascade do |t|
    t.integer "user_id",     limit: 4
    t.integer "language_id", limit: 4
  end

  add_index "users_languages", ["language_id"], name: "index_users_languages_on_language_id", using: :btree
  add_index "users_languages", ["user_id"], name: "index_users_languages_on_user_id", using: :btree

end
