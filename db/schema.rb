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

ActiveRecord::Schema.define(version: 20151017211329) do

  create_table "assets", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "asset"
    t.integer  "ticket_id"
    t.string   "content_type"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "state_id"
    t.integer  "previous_state_id"
  end

  add_index "comments", ["ticket_id"], name: "index_comments_on_ticket_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "thing_id"
    t.string   "thing_type"
    t.string   "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "color"
    t.string   "background"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "default"
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "state_id"
  end

  add_index "tickets", ["project_id"], name: "index_tickets_on_project_id"
  add_index "tickets", ["state_id"], name: "index_tickets_on_state_id"
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
  end

end
