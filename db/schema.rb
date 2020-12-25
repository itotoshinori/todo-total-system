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

ActiveRecord::Schema.define(version: 2020_12_03_124632) do

  create_table "accounts", force: :cascade do |t|
    t.integer "item"
    t.integer "todo_id"
    t.integer "amount"
    t.date "registrationdate"
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "expense", default: false, null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.date "postdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.string "explanation"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.integer "todo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "name"
    t.string "body"
    t.integer "blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "url"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "portals", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "companyname"
    t.string "president"
    t.string "headoffice"
    t.string "tel"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "todos", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "household_id"
    t.text "title", null: false
    t.string "body"
    t.boolean "finished", default: false
    t.date "term", null: false
    t.time "starttime"
    t.time "finishtime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "finishday"
    t.integer "account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "placecode"
  end

end
