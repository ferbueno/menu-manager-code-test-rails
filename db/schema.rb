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

ActiveRecord::Schema[7.0].define(version: 2022_02_11_042824) do
  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 20, scale: 4
    t.string "name_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_hash"], name: "index_dishes_on_name_hash", unique: true
  end

  create_table "menu_dishes", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_menu_dishes_on_dish_id"
    t.index ["menu_id", "dish_id"], name: "index_menu_dishes_on_menu_id_and_dish_id", unique: true
    t.index ["menu_id"], name: "index_menu_dishes_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "menu_dishes", "dishes"
  add_foreign_key "menu_dishes", "menus"
end
