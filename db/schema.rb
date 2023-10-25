# rubocop: disable all

ActiveRecord::Schema.define(version: 2023_07_18_104828) do

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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "budgets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.bigint "subcategory_id"
    t.decimal "amount", precision: 10, scale: 2
    t.text "notes"
    t.integer "month", null: false
    t.integer "year", default: -> { "EXTRACT(year FROM CURRENT_TIMESTAMP)" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_budgets_on_category_id"
    t.index ["month", "year"], name: "index_budgets_on_month_and_year"
    t.index ["subcategory_id"], name: "index_budgets_on_subcategory_id"
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name"
    t.index ["organization_id"], name: "index_categories_on_organization_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.bigint "subcategory_id"
    t.date "date"
    t.integer "month", null: false
    t.integer "year", default: -> { "EXTRACT(year FROM CURRENT_TIMESTAMP)" }, null: false
    t.decimal "amount", precision: 10, scale: 2
    t.text "notes"
    t.string "attachment"
    t.integer "status", default: 0, null: false
    t.text "rejection_reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id", "status"], name: "index_expenses_on_category_id_and_status"
    t.index ["category_id"], name: "index_expenses_on_category_id"
    t.index ["status"], name: "index_expenses_on_status"
    t.index ["subcategory_id"], name: "index_expenses_on_subcategory_id"
    t.index ["user_id", "status"], name: "index_expenses_on_user_id_and_status"
    t.index ["user_id"], name: "index_expenses_on_user_id"
    t.index ["year"], name: "index_expenses_on_year"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "message"
    t.boolean "read", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["read"], name: "index_notifications_on_read"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "subdomain", null: false
    t.string "email", null: false
    t.text "address", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "remember_me?", default: false, null: false
    t.boolean "is_admin?", default: false, null: false
    t.datetime "invitation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email", "organization_id"], name: "index_users_on_email_and_organization_id", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.integer "month", null: false
    t.integer "year", default: -> { "EXTRACT(year FROM CURRENT_TIMESTAMP)" }, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "month", "year"], name: "index_wallets_on_user_id_and_month_and_year", unique: true
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "budgets", "categories"
  add_foreign_key "budgets", "subcategories"
  add_foreign_key "budgets", "users"
  add_foreign_key "categories", "organizations"
  add_foreign_key "expenses", "categories"
  add_foreign_key "expenses", "subcategories"
  add_foreign_key "expenses", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "users", "organizations"
  add_foreign_key "wallets", "users"
end
