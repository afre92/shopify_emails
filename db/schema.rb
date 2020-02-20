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

ActiveRecord::Schema.define(version: 2020_02_06_011213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "emails", force: :cascade do |t|
    t.datetime "scheduled_time"
    t.integer "was_sent", default: 0
    t.integer "tracking_pixel_id"
    t.text "html"
    t.bigint "template_id"
    t.bigint "shop_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_emails_on_order_id"
    t.index ["shop_id"], name: "index_emails_on_shop_id"
    t.index ["template_id"], name: "index_emails_on_template_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.string "shopify_id"
    t.string "variant_id"
    t.string "title"
    t.integer "quantity"
    t.bigint "order_id"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "shopify_id"
    t.string "email"
    t.datetime "shopify_created_at"
    t.bigint "shop_id"
    t.jsonb "customer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_orders_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.string "web_token", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: ""
    t.integer "subscription_type", default: 0
    t.float "tokens", default: 10.0
    t.string "address", default: ""
    t.string "owner_first_name", default: ""
    t.string "owner_last_name", default: ""
    t.string "phone", default: ""
    t.string "shop_name", default: ""
    t.string "title", default: "Founder"
    t.string "website", default: ""
    t.integer "review_interval", default: 10
    t.integer "thank_you_interval", default: 10
    t.integer "status", default: 0
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "templates", force: :cascade do |t|
    t.string "from", default: ""
    t.integer "template_type", default: 0
    t.string "subject", default: ""
    t.string "reply_to", default: ""
    t.jsonb "body", default: "{}"
    t.bigint "shop_id"
    t.text "html", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_templates_on_shop_id"
  end

  create_table "tracking_pixels", force: :cascade do |t|
    t.bigint "template_id"
    t.bigint "shop_id"
    t.bigint "email_id"
    t.string "token"
    t.integer "views", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_id"], name: "index_tracking_pixels_on_email_id"
    t.index ["shop_id"], name: "index_tracking_pixels_on_shop_id"
    t.index ["template_id"], name: "index_tracking_pixels_on_template_id"
  end

end
