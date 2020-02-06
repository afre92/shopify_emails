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
    t.integer "template_id"
    t.integer "shop_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "html"
  end

  create_table "order_items", force: :cascade do |t|
    t.string "shopify_id"
    t.string "variant_id"
    t.string "title"
    t.integer "quantity"
    t.integer "order_id"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "shopify_id"
    t.string "email"
    t.datetime "shopify_created_at"
    t.integer "shop_id"
    t.jsonb "customer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "review_templates", force: :cascade do |t|
    t.string "from", default: ""
    t.string "subject", default: ""
    t.string "reply_to", default: ""
    t.jsonb "body"
    t.integer "shop_id"
    t.text "html", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
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
    t.integer "shop_id"
    t.text "html", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "thank_you_templates", force: :cascade do |t|
    t.string "from", default: ""
    t.string "subject", default: ""
    t.string "reply_to", default: ""
    t.jsonb "body", default: "{\"counters\":{\"u_column\":1,\"u_row\":1,\"u_content_text\":1},\"body\":{\"rows\":[{\"cells\":[1],\"columns\":[{\"contents\":[{\"type\":\"text\",\"values\":{\"containerPadding\":\"10px\",\"_meta\":{\"htmlID\":\"u_content_text_1\",\"htmlClassNames\":\"u_content_text\"},\"selectable\":true,\"draggable\":true,\"deletable\":true,\"color\":\"#000000\",\"textAlign\":\"left\",\"lineHeight\":\"140%\",\"linkStyle\":{\"inherit\":true,\"linkColor\":\"#0000ee\",\"linkHoverColor\":\"#0000ee\",\"linkUnderline\":true,\"linkHoverUnderline\":true},\"text\":\"<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\">&nbsp;</p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\">&nbsp;</p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">Hi {{customer.first_name}},</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">I really want to send you a special thanks for visiting {{shop.shop_name}}</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">I hope you had a great experience on our online store. If you have any problems, you can contact me directly through this email address.</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">I am always here and ready to answer all your questions. Wish you a good day!</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">Best regards,</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">{{shop.shop_full_name}}</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\"><span style=\\\"text-align: center; line-height: 19.6px; font-size: 14px;\\\">{{shop.owner_title}},&nbsp;</span>{{shop.shop_name}}</span></p>\"}}],\"values\":{\"backgroundColor\":\"\",\"padding\":\"0px\",\"border\":{},\"_meta\":{\"htmlID\":\"u_column_1\",\"htmlClassNames\":\"u_column\"}}}],\"values\":{\"columns\":false,\"backgroundColor\":\"\",\"columnsBackgroundColor\":\"\",\"backgroundImage\":{\"url\":\"\",\"fullWidth\":true,\"repeat\":false,\"center\":true,\"cover\":false},\"padding\":\"0px\",\"hideDesktop\":false,\"hideMobile\":false,\"noStackMobile\":false,\"_meta\":{\"htmlID\":\"u_row_1\",\"htmlClassNames\":\"u_row\"},\"selectable\":true,\"draggable\":true,\"deletable\":true}}],\"values\":{\"backgroundColor\":\"#ffffff\",\"backgroundImage\":{\"url\":\"\",\"fullWidth\":true,\"repeat\":false,\"center\":true,\"cover\":false},\"contentWidth\":\"500px\",\"fontFamily\":{\"label\":\"Arial\",\"value\":\"arial,helvetica,sans-serif\"},\"linkStyle\":{\"body\":true,\"linkColor\":\"#0000ee\",\"linkHoverColor\":\"#0000ee\",\"linkUnderline\":true,\"linkHoverUnderline\":true},\"_meta\":{\"htmlID\":\"u_body\",\"htmlClassNames\":\"u_body\"}}}}"
    t.integer "shop_id"
    t.text "html", default: " <!DOCTYPE HTML PUBLIC &quot;-//W3C//DTD XHTML 1.0 Transitional //EN&quot; &quot;http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd&quot;><html xmlns=&quot;http://www.w3.org/1999/xhtml&quot; xmlns:v=&quot;urn:schemas-microsoft-com:vml&quot; xmlns:o=&quot;urn:schemas-microsoft-com:office:office&quot;><head> <!--[if gte mso 9]> <xml> <o:OfficeDocumentSettings> <o:AllowPNG/> <o:PixelsPerInch>96</o:PixelsPerInch> </o:OfficeDocumentSettings> </xml> <![endif]--><meta http-equiv=&quot;Content-Type&quot; content=&quot;text/html; charset=UTF-8&quot;><meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;><meta name=&quot;x-apple-disable-message-reformatting&quot;> <!--[if !mso]><!--><meta http-equiv=&quot;X-UA-Compatible&quot; content=&quot;IE=edge&quot;><!--<![endif]--><title></title><style type=&quot;text/css&quot;>a{color:#00e;text-decoration:underline}body{margin:0;padding:0}table,tr,td{vertical-align:top;border-collapse:collapse}p,ul{margin:0}.ie-container table, .mso-container table{table-layout:fixed}*{line-height:inherit}a[x-apple-data-detectors=true]{color:inherit !important;text-decoration:none !important}.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div{line-height:100%}[owa] .email-row .email-col{display:table-cell;float:none !important;vertical-align:top}.ie-container .email-col-100, .ie-container .email-row, [owa] .email-col-100, [owa] .email-row{width:500px !important}.ie-container .email-col-17, [owa] .email-col-17{width:85px !important}.ie-container .email-col-25, [owa] .email-col-25{width:125px !important}.ie-container .email-col-33, [owa] .email-col-33{width:165px !important}.ie-container .email-col-50, [owa] .email-col-50{width:250px !important}.ie-container .email-col-67, [owa] .email-col-67{width:335px !important}@media only screen and (min-width: 520px){.email-row{width:500px !important}.email-row .email-col{vertical-align:top}.email-row .email-col-100{width:500px !important}.email-row .email-col-67{width:335px !important}.email-row .email-col-50{width:250px !important}.email-row .email-col-33{width:165px !important}.email-row .email-col-25{width:125px !important}.email-row .email-col-17{width:85px !important}}@media (max-width: 520px){.email-row-container{padding-left:0px !important;padding-right:0px !important}.email-row .email-col{min-width:320px !important;max-width:100% !important;display:block !important}.email-row{width:calc(100% - 40px) !important}.email-col{width:100% !important}.email-col>div{margin:0 auto}.no-stack .email-col{min-width:0 !important;display:table-cell !important}.no-stack .email-col-50{width:50% !important}.no-stack .email-col-33{width:33% !important}.no-stack .email-col-67{width:67% !important}.no-stack .email-col-25{width:25% !important}.no-stack .email-col-17{width:17% !important}}@media (max-width: 480px){.hide-mobile{display:none !important;max-height:0px;overflow:hidden}}@media (min-width: 980px){.hide-desktop{display:none !important;max-height:none !important}}</style><!--[if mso]><style type=&quot;text/css&quot;>ul li{list-style:disc inside;mso-special-format:bullet}</style><![endif]--></head><body class=&quot;clean-body&quot; style=&quot;margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #ffffff&quot;> <!--[if IE]><div class=&quot;ie-container&quot;><![endif]--> <!--[if mso]><div class=&quot;mso-container&quot;><![endif]--><table class=&quot;nl-container&quot; style=&quot;border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #ffffff;width:100%&quot; cellpadding=&quot;0&quot; cellspacing=&quot;0&quot;><tbody><tr style=&quot;vertical-align: top&quot;><td style=&quot;word-break: break-word;border-collapse: collapse !important;vertical-align: top&quot;> <!--[if (mso)|(IE)]><table width=&quot;100%&quot; cellpadding=&quot;0&quot; cellspacing=&quot;0&quot; border=&quot;0&quot;><tr><td align=&quot;center&quot; style=&quot;background-color: #ffffff;&quot;><![endif]--><div class=&quot;email-row-container&quot; style=&quot;padding: 0px;background-color: transparent&quot;><div style=&quot;Margin: 0 auto;min-width: 320px;max-width: 500px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;&quot; class=&quot;email-row&quot;><div style=&quot;border-collapse: collapse;display: table;width: 100%;background-color: transparent;&quot;> <!--[if (mso)|(IE)]><table width=&quot;100%&quot; cellpadding=&quot;0&quot; cellspacing=&quot;0&quot; border=&quot;0&quot;><tr><td style=&quot;padding: 0px;background-color: transparent;&quot; align=&quot;center&quot;><table cellpadding=&quot;0&quot; cellspacing=&quot;0&quot; border=&quot;0&quot; style=&quot;width:500px;&quot;><tr style=&quot;background-color: transparent;&quot;><![endif]--> <!--[if (mso)|(IE)]><td align=&quot;center&quot; width=&quot;500&quot; style=&quot;width: 500px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;&quot; valign=&quot;top&quot;><![endif]--><div class=&quot;email-col email-col-100&quot; style=&quot;max-width: 320px;min-width: 500px;display: table-cell;vertical-align: top;&quot;><div style=&quot;width: 100% !important;&quot;> <!--[if (!mso)&amp;(!IE)]><!--><div style=&quot;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;&quot;><!--<![endif]--><table id=&quot;u_content_text_1&quot; class=&quot;u_content_text&quot; style=&quot;font-family:arial,helvetica,sans-serif;&quot; role=&quot;presentation&quot; cellpadding=&quot;0&quot; cellspacing=&quot;0&quot; width=&quot;100%&quot; border=&quot;0&quot;><tbody><tr><td style=&quot;overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:arial,helvetica,sans-serif;&quot; align=&quot;left&quot;><div style=&quot;color: #000000; line-height: 140%; text-align: left; word-wrap: break-word;&quot;><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;>&amp;nbsp;</p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;>&amp;nbsp;</p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;><span style=&quot;font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;&quot;>Hi {{customer.first_name}}, TEST, TESETSSS</span></p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;><span style=&quot;font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;&quot;>&amp;nbsp;</span></p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;><span style=&quot;font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;&quot;>I really want to send you a special thanks for visiting {{shop.shop_name}}</span></p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;><span style=&quot;font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;&quot;>&amp;nbsp;</span></p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;><span style=&quot;font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;&quot;>I hope you had a great experience on our online store. If you have any problems, you can contact me directly through this email address.</span></p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;><span style=&quot;font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;&quot;>&amp;nbsp;</span></p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;><span style=&quot;font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;&quot;>I am always here and ready to answer all your questions. Wish you a good day!</span></p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;><span style=&quot;font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;&quot;>&amp;nbsp;</span></p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;><span style=&quot;font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;&quot;>Best regards,</span></p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;><span style=&quot;font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;&quot;>{{shop.shop_full_name}}</span></p><p style=&quot;background-color: #ffffff; line-height: 140%; font-size: 14px;&quot;><span style=&quot;font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;&quot;><span style=&quot;text-align: center; line-height: 19.6px; font-size: 14px;&quot;>{{shop.owner_title}},&amp;nbsp;</span>{{shop.shop_name}}</span></p></div></td></tr></tbody></table><!--[if (!mso)&amp;(!IE)]><!--></div><!--<![endif]--></div></div> <!--[if (mso)|(IE)]></td><![endif]--> <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]--></div></div></div><!--[if (mso)|(IE)]></td></tr></table><![endif]--></td></tr></tbody></table> <!--[if (mso)|(IE)]></div><![endif]--></body></html> "
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracking_pixels", force: :cascade do |t|
    t.integer "template_id"
    t.integer "shop_id"
    t.integer "email_id"
    t.string "token"
    t.integer "views", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
