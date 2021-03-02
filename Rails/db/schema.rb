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

ActiveRecord::Schema.define(version: 2021_03_02_212101) do

  create_table "active_storage_attachments", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cart_products", charset: "utf8mb4", force: :cascade do |t|
    t.decimal "total_price", precision: 8, scale: 2, null: false
    t.integer "quantity", null: false
    t.bigint "cart_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_cart_products_on_cart_id"
    t.index ["product_id"], name: "index_cart_products_on_product_id"
    t.check_constraint "`quantity` > 0", name: "quantity_cart_product_check"
    t.check_constraint "`total_price` > 0", name: "price_cart_product_check"
  end

  create_table "carts", charset: "utf8mb4", force: :cascade do |t|
    t.decimal "sub_total", precision: 8, scale: 2, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
    t.check_constraint "`sub_total` >= 0", name: "price_cart_check"
  end

  create_table "command_products", charset: "utf8mb4", force: :cascade do |t|
    t.integer "quantity", null: false
    t.decimal "total_price", precision: 8, scale: 2, null: false
    t.decimal "unit_price", precision: 8, scale: 2, null: false
    t.bigint "product_id", null: false
    t.bigint "command_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["command_id"], name: "index_command_products_on_command_id"
    t.index ["product_id"], name: "index_command_products_on_product_id"
  end

  create_table "commands", charset: "utf8mb4", force: :cascade do |t|
    t.decimal "sub_total", precision: 8, scale: 2, null: false
    t.decimal "tps", precision: 8, scale: 2, null: false
    t.decimal "tvq", precision: 8, scale: 2, null: false
    t.decimal "total", precision: 8, scale: 2, null: false
    t.boolean "store_pickup", null: false
    t.string "state", limit: 50, null: false
    t.string "shipping_adress", limit: 159, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_commands_on_user_id"
  end

  create_table "conversations", charset: "utf8mb4", force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.string "description", limit: 2500, null: false
    t.bigint "user_id", null: false
    t.bigint "admin_id", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_conversations_on_admin_id"
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "current_taxes", charset: "utf8mb4", force: :cascade do |t|
    t.decimal "tps", precision: 8, scale: 2, null: false
    t.decimal "tvq", precision: 8, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", charset: "utf8mb4", force: :cascade do |t|
    t.string "body", limit: 2500, null: false
    t.bigint "conversation_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "products", charset: "utf8mb4", force: :cascade do |t|
    t.string "category", limit: 50, null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.string "title", limit: 50, null: false
    t.string "description", limit: 2500, null: false
    t.integer "quantity", null: false
    t.string "animal_type", limit: 50, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category", "title", "description", "animal_type"], name: "fulltext_products", type: :fulltext
    t.check_constraint "`price` > 0", name: "price_product_check"
    t.check_constraint "`quantity` >= 0", name: "quantity_product_check"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", limit: 50, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "firstname", limit: 50, null: false
    t.string "lastname", limit: 50, null: false
    t.virtual "fullname", type: :string, limit: 101, as: "concat(`firstname`,' ',`lastname`)"
    t.string "address", limit: 50, null: false
    t.string "city", limit: 50, null: false
    t.string "postal_code", limit: 6, null: false
    t.string "province", limit: 50, null: false
    t.string "phone_number", limit: 10, null: false
    t.boolean "is_admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email", "firstname", "lastname", "address", "city", "postal_code", "province", "phone_number"], name: "fulltext_users", type: :fulltext
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_products", "carts"
  add_foreign_key "cart_products", "products"
  add_foreign_key "carts", "users"
  add_foreign_key "command_products", "commands"
  add_foreign_key "command_products", "products"
  add_foreign_key "commands", "users"
  add_foreign_key "conversations", "users"
  add_foreign_key "conversations", "users", column: "admin_id"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
end
