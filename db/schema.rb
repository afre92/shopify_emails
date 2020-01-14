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

ActiveRecord::Schema.define(version: 2020_01_14_013636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: ""
    t.integer "subscription_type", default: 0
    t.float "tokens", default: 10.0
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "templates", force: :cascade do |t|
    t.string "from"
    t.string "subject"
    t.string "reply_to"
    t.jsonb "body", default: "{\"counters\":{\"u_column\":1,\"u_row\":1,\"u_content_text\":1},\"body\":{\"rows\":[{\"cells\":[1],\"columns\":[{\"contents\":[{\"type\":\"text\",\"values\":{\"containerPadding\":\"10px\",\"_meta\":{\"htmlID\":\"u_content_text_1\",\"htmlClassNames\":\"u_content_text\"},\"selectable\":true,\"draggable\":true,\"deletable\":true,\"color\":\"#000000\",\"textAlign\":\"left\",\"lineHeight\":\"140%\",\"linkStyle\":{\"inherit\":true,\"linkColor\":\"#0000ee\",\"linkHoverColor\":\"#0000ee\",\"linkUnderline\":true,\"linkHoverUnderline\":true},\"text\":\"<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\">&nbsp;</p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\">&nbsp;</p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">Hi {{customer.first_name}},</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">I really want to send you a special thanks for visiting {{shop.shop_name}}</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">I hope you had a great experience on our online store. If you have any problems, you can contact me directly through this email address.</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">I am always here and ready to answer all your questions. Wish you a good day!</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">Best regards,</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">{{shop.shop_full_name}}</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\"><span style=\\\"text-align: center; line-height: 19.6px; font-size: 14px;\\\">{{shop.owner_title}},&nbsp;</span>{{shop.shop_name}}</span></p>\"}}],\"values\":{\"backgroundColor\":\"\",\"padding\":\"0px\",\"border\":{},\"_meta\":{\"htmlID\":\"u_column_1\",\"htmlClassNames\":\"u_column\"}}}],\"values\":{\"columns\":false,\"backgroundColor\":\"\",\"columnsBackgroundColor\":\"\",\"backgroundImage\":{\"url\":\"\",\"fullWidth\":true,\"repeat\":false,\"center\":true,\"cover\":false},\"padding\":\"0px\",\"hideDesktop\":false,\"hideMobile\":false,\"noStackMobile\":false,\"_meta\":{\"htmlID\":\"u_row_1\",\"htmlClassNames\":\"u_row\"},\"selectable\":true,\"draggable\":true,\"deletable\":true}}],\"values\":{\"backgroundColor\":\"#ffffff\",\"backgroundImage\":{\"url\":\"\",\"fullWidth\":true,\"repeat\":false,\"center\":true,\"cover\":false},\"contentWidth\":\"500px\",\"fontFamily\":{\"label\":\"Arial\",\"value\":\"arial,helvetica,sans-serif\"},\"linkStyle\":{\"body\":true,\"linkColor\":\"#0000ee\",\"linkHoverColor\":\"#0000ee\",\"linkUnderline\":true,\"linkHoverUnderline\":true},\"_meta\":{\"htmlID\":\"u_body\",\"htmlClassNames\":\"u_body\"}}}}"
    t.integer "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "html"
  end

end
