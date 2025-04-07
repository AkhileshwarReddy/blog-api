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

ActiveRecord::Schema[7.1].define(version: 2025_03_28_064215) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_authors_on_email", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.integer "copies"
    t.string "name"
    t.integer "late_return_penalty"
    t.bigint "publisher_author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_read_days"
    t.index ["isbn"], name: "index_books_on_isbn", unique: true
    t.index ["publisher_author_id"], name: "index_books_on_publisher_author_id"
  end

  create_table "borrows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.datetime "borrowed_date"
    t.datetime "estimated_return_date"
    t.datetime "actual_return_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_borrows_on_book_id"
    t.index ["user_id"], name: "index_borrows_on_user_id"
  end

  create_table "publisher_authors", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "publisher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_publisher_authors_on_author_id"
    t.index ["publisher_id"], name: "index_publisher_authors_on_publisher_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "limit", default: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "books", "publisher_authors"
  add_foreign_key "borrows", "books"
  add_foreign_key "borrows", "users"
  add_foreign_key "publisher_authors", "authors"
  add_foreign_key "publisher_authors", "publishers"
end
