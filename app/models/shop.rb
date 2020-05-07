# frozen_string_literal: true

class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :templates, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_many :reviews, through: :orders

  before_create :create_unique_token
  after_create :get_shop_info, :associate_templates

  enum subscription_type: { free: 0, basic: 1, pro: 2 }

  def associate_templates
    # Create Thank You Template
    Template.create(
      shop_id: id,
      from: email,
      reply_to: email,
      subject: "I really want to send you a special thanks for visiting our store",
      template_type: 'thank_you',
      body: "{\"counters\":{\"u_column\":1,\"u_row\":1,\"u_content_text\":1,\"u_content_image\":1},\"body\":{\"rows\":[{\"cells\":[1],\"columns\":[{\"contents\":[{\"type\":\"image\",\"values\":{\"containerPadding\":\"10px\",\"_meta\":{\"htmlID\":\"u_content_image_1\",\"htmlClassNames\":\"u_content_image\"},\"selectable\":true,\"draggable\":true,\"deletable\":true,\"src\":{\"url\":\"https://via.placeholder.com/500x100?text=REPLACE THIS WITH YOUR LOGO\",\"width\":500,\"height\":100},\"textAlign\":\"center\",\"altText\":\"Image\",\"action\":{\"name\":\"web\",\"values\":{\"href\":\"\",\"target\":\"_blank\"}}}},{\"type\":\"text\",\"values\":{\"containerPadding\":\"10px\",\"_meta\":{\"htmlID\":\"u_content_text_1\",\"htmlClassNames\":\"u_content_text\"},\"selectable\":true,\"draggable\":true,\"deletable\":true,\"color\":\"#000000\",\"textAlign\":\"left\",\"lineHeight\":\"140%\",\"linkStyle\":{\"inherit\":true,\"linkColor\":\"#0000ee\",\"linkHoverColor\":\"#0000ee\",\"linkUnderline\":true,\"linkHoverUnderline\":true},\"text\":\"<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\">&nbsp;</p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\">&nbsp;</p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">Hi {{customer.first_name}}&nbsp;</span><span style=\\\"font-family: helvetica, sans-serif; font-size: 14px; line-height: 19.6px;\\\">{{customer.last_name}}</span><span style=\\\"font-family: helvetica, sans-serif; font-size: 14px; line-height: 19.6px;\\\">,</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">I really want to send you a special thanks for visiting {{shop.shop_name}}</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">I hope you had a great experience on our online store. If you have any problems, you can contact me directly through this email address.</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">I am always here and ready to answer all your questions. Wish you a good day!</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">Best regards,</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\"><span style=\\\"text-align: center; line-height: 19.6px; font-size: 14px;\\\">{{shop.title}},&nbsp;</span>{{shop.shop_name}}</span></p>\"}}],\"values\":{\"backgroundColor\":\"\",\"padding\":\"0px\",\"border\":{},\"_meta\":{\"htmlID\":\"u_column_1\",\"htmlClassNames\":\"u_column\"}}}],\"values\":{\"columns\":false,\"backgroundColor\":\"\",\"columnsBackgroundColor\":\"\",\"backgroundImage\":{\"url\":\"\",\"fullWidth\":true,\"repeat\":false,\"center\":true,\"cover\":false},\"padding\":\"0px\",\"hideDesktop\":false,\"hideMobile\":false,\"noStackMobile\":false,\"_meta\":{\"htmlID\":\"u_row_1\",\"htmlClassNames\":\"u_row\"},\"selectable\":true,\"draggable\":true,\"deletable\":true}}],\"values\":{\"backgroundColor\":\"#ffffff\",\"backgroundImage\":{\"url\":\"\",\"fullWidth\":true,\"repeat\":false,\"center\":true,\"cover\":false},\"contentWidth\":\"500px\",\"fontFamily\":{\"label\":\"Arial\",\"value\":\"arial,helvetica,sans-serif\"},\"linkStyle\":{\"body\":true,\"linkColor\":\"#0000ee\",\"linkHoverColor\":\"#0000ee\",\"linkUnderline\":true,\"linkHoverUnderline\":true},\"_meta\":{\"htmlID\":\"u_body\",\"htmlClassNames\":\"u_body\"}}}}",
      html: "\n<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\n<head>\n<!--[if gte mso 9]>\n<xml>\n  <o:OfficeDocumentSettings>\n    <o:AllowPNG/>\n    <o:PixelsPerInch>96</o:PixelsPerInch>\n  </o:OfficeDocumentSettings>\n</xml>\n<![endif]-->\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n  <meta name=\"x-apple-disable-message-reformatting\">\n  <!--[if !mso]><!--><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><!--<![endif]-->\n  <title></title>\n  \n    <style type=\"text/css\">\n      a { color: #0000ee; text-decoration: underline; }\nbody {\n  margin: 0;\n  padding: 0;\n}\n\ntable,\ntr,\ntd {\n  vertical-align: top;\n  border-collapse: collapse;\n}\n\np,\nul {\n  margin: 0;\n}\n\n.ie-container table,\n.mso-container table {\n  table-layout: fixed;\n}\n\n* {\n  line-height: inherit;\n}\n\na[x-apple-data-detectors='true'] {\n  color: inherit !important;\n  text-decoration: none !important;\n}\n\n.ExternalClass,\n.ExternalClass p,\n.ExternalClass span,\n.ExternalClass font,\n.ExternalClass td,\n.ExternalClass div {\n  line-height: 100%;\n}\n\n[owa] .email-row .email-col {\n  display: table-cell;\n  float: none !important;\n  vertical-align: top;\n}\n\n.ie-container .email-col-100,\n.ie-container .email-row,\n[owa] .email-col-100,\n[owa] .email-row {\n  width: 500px !important;\n}\n.ie-container .email-col-17,\n[owa] .email-col-17 {\n  width: 85px !important;\n}\n.ie-container .email-col-25,\n[owa] .email-col-25 {\n  width: 125px !important;\n}\n.ie-container .email-col-33,\n[owa] .email-col-33 {\n  width: 165px !important;\n}\n.ie-container .email-col-50,\n[owa] .email-col-50 {\n  width: 250px !important;\n}\n.ie-container .email-col-67,\n[owa] .email-col-67 {\n  width: 335px !important;\n}\n\n@media only screen and (min-width: 520px) {\n  .email-row {\n    width: 500px !important;\n  }\n  .email-row .email-col {\n    vertical-align: top;\n  }\n  .email-row .email-col-100 {\n    width: 500px !important;\n  }\n  .email-row .email-col-67 {\n    width: 335px !important;\n  }\n  .email-row .email-col-50 {\n    width: 250px !important;\n  }\n  .email-row .email-col-33 {\n    width: 165px !important;\n  }\n  .email-row .email-col-25 {\n    width: 125px !important;\n  }\n  .email-row .email-col-17 {\n    width: 85px !important;\n  }\n}\n\n@media (max-width: 520px) {\n  .email-row-container {\n    padding-left: 0px !important;\n    padding-right: 0px !important;\n  }\n  .email-row .email-col {\n    min-width: 320px !important;\n    max-width: 100% !important;\n    display: block !important;\n  }\n  .email-row {\n    width: calc(100% - 40px) !important;\n  }\n  .email-col {\n    width: 100% !important;\n  }\n  .email-col > div {\n    margin: 0 auto;\n  }\n  .no-stack .email-col {\n    min-width: 0 !important;\n    display: table-cell !important;\n  }\n  .no-stack .email-col-50 {\n    width: 50% !important;\n  }\n  .no-stack .email-col-33 {\n    width: 33% !important;\n  }\n  .no-stack .email-col-67 {\n    width: 67% !important;\n  }\n  .no-stack .email-col-25 {\n    width: 25% !important;\n  }\n  .no-stack .email-col-17 {\n    width: 17% !important;\n  }\n}\n\n@media (max-width: 480px) {\n  .hide-mobile {\n    display: none !important;\n    max-height: 0px;\n    overflow: hidden;\n  }\n\n  .full-width-mobile {\n    width: 100% !important;\n    max-width: 100% !important;\n  }\n}\n\n@media (min-width: 980px) {\n  .hide-desktop {\n    display: none !important;\n    max-height: none !important;\n  }\n}\n\n    </style>\n  \n  \n<!--[if mso]>\n<style type=\"text/css\">\n  ul li {\n    list-style:disc inside;\n    mso-special-format:bullet;\n  }\n</style>\n<![endif]-->\n\n</head>\n\n<body class=\"clean-body\" style=\"margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #ffffff\">\n  <!--[if IE]><div class=\"ie-container\"><![endif]-->\n  <!--[if mso]><div class=\"mso-container\"><![endif]-->\n  <table class=\"nl-container\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #ffffff;width:100%\" cellpadding=\"0\" cellspacing=\"0\">\n  <tbody>\n  <tr style=\"vertical-align: top\">\n    <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\n    <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" style=\"background-color: #ffffff;\"><![endif]-->\n    \n\n<div class=\"email-row-container\" style=\"padding: 0px;background-color: transparent\">\n  <div style=\"Margin: 0 auto;min-width: 320px;max-width: 500px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\" class=\"email-row\">\n    <div style=\"border-collapse: collapse;display: table;width: 100%;background-color: transparent;\">\n      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:500px;\"><tr style=\"background-color: transparent;\"><![endif]-->\n      \n<!--[if (mso)|(IE)]><td align=\"center\" width=\"500\" style=\"width: 500px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\n<div class=\"email-col email-col-100\" style=\"max-width: 320px;min-width: 500px;display: table-cell;vertical-align: top;\">\n  <div style=\"width: 100% !important;\">\n  <!--[if (!mso)&(!IE)]><!--><div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\n  \n<table id=\"u_content_image_1\" class=\"u_content_image\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n  <tbody>\n    <tr>\n      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n        \n<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n  <tr>\n    <td style=\"padding-right: 0px;padding-left: 0px;\" align=\"center\">\n      \n      <img align=\"center\" border=\"0\" src=\"https://via.placeholder.com/500x100?text=REPLACE THIS WITH YOUR LOGO\" alt=\"Image\" title=\"Image\" style=\"outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;clear: both;display: block !important;border: none;height: auto;float: none;width: 100%;max-width: 480px;\" width=\"480\"/>\n      \n    </td>\n  </tr>\n</table>\n\n      </td>\n    </tr>\n  </tbody>\n</table>\n\n<table id=\"u_content_text_1\" class=\"u_content_text\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n  <tbody>\n    <tr>\n      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n        \n  <div style=\"color: #000000; line-height: 140%; text-align: left; word-wrap: break-word;\">\n    <p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\">&nbsp;</p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\">&nbsp;</p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">Hi {{customer.first_name}} </span><span style=\"font-family: helvetica, sans-serif; font-size: 14px; line-height: 19.6px;\">{{customer.last_name}}</span><span style=\"font-family: helvetica, sans-serif; font-size: 14px; line-height: 19.6px;\">,</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">&nbsp;</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">I really want to send you a special thanks for visiting {{shop.shop_name}}</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">&nbsp;</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">I hope you had a great experience on our online store. If you have any problems, you can contact me directly through this email address.</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">&nbsp;</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">I am always here and ready to answer all your questions. Wish you a good day!</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">&nbsp;</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">Best regards,</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\"><span style=\"text-align: center; line-height: 19.6px; font-size: 14px;\">{{shop.title}},&nbsp;</span>{{shop.shop_name}}</span></p>\n  </div>\n\n      </td>\n    </tr>\n  </tbody>\n</table>\n\n  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\n  </div>\n</div>\n<!--[if (mso)|(IE)]></td><![endif]-->\n      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\n    </div>\n  </div>\n</div>\n\n\n    <!--[if (mso)|(IE)]></td></tr></table><![endif]-->\n    </td>\n  </tr>\n  </tbody>\n  </table>\n  <!--[if (mso)|(IE)]></div><![endif]-->\n</body>\n\n</html>\n" 
    )
    
    # Create Review Template
    Template.create(
      shop_id: id,
      from: email,
      reply_to: email,
      subject: "We'd love feedback on your recent #{shop_name} purchase",
      template_type: 'review',
      body: "{\"counters\":{\"u_column\":5,\"u_row\":4,\"u_content_text\":3,\"u_content_html\":1,\"u_content_image\":1},\"body\":{\"rows\":[{\"cells\":[1],\"columns\":[{\"contents\":[{\"type\":\"image\",\"values\":{\"containerPadding\":\"10px\",\"_meta\":{\"htmlID\":\"u_content_image_1\",\"htmlClassNames\":\"u_content_image\"},\"selectable\":true,\"draggable\":true,\"deletable\":true,\"src\":{\"url\":\"https://via.placeholder.com/500x100?text=REPLACE THIS WITH YOUR LOGO\",\"width\":500,\"height\":100},\"textAlign\":\"center\",\"altText\":\"Image\",\"action\":{\"name\":\"web\",\"values\":{\"href\":\"\",\"target\":\"_blank\"}}}},{\"type\":\"text\",\"values\":{\"containerPadding\":\"10px\",\"_meta\":{\"htmlID\":\"u_content_text_1\",\"htmlClassNames\":\"u_content_text\"},\"selectable\":true,\"draggable\":true,\"deletable\":true,\"color\":\"#000000\",\"textAlign\":\"left\",\"lineHeight\":\"140%\",\"linkStyle\":{\"inherit\":true,\"linkColor\":\"#0000ee\",\"linkHoverColor\":\"#0000ee\",\"linkUnderline\":true,\"linkHoverUnderline\":true},\"text\":\"<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\">&nbsp;</p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\">&nbsp;</p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px; text-align: center;\\\"><strong><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">Hi {{customer.first_name}}&nbsp; {{customer.last_name}} !</span></strong></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\">&nbsp;</p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">A few weeks ago we fulfilled your order of<strong> {{product_name}}</strong>. At {{ shop.shop_name }}, we take out customer satisfaction seriously -&nbsp; if there is an issue with your order, we aim to offer a reasonable solution within 1-2 working days via out support channel ({{ shop.email }})</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\">&nbsp;</p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\">We'd love feedback &amp; testimonials from our past customers to help build trust among new customers. if you are satisfied with our product or customer service so far, we'd greatly appreciate it if you could leave us a positive rating or review.</p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\">Best regards,</span></p>\\n<p style=\\\"background-color: #ffffff; line-height: 140%; font-size: 14px;\\\"><span style=\\\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\\\"><span style=\\\"text-align: center; line-height: 19.6px; font-size: 14px;\\\">&nbsp;</span>{{shop.shop_name}}</span></p>\"}}],\"values\":{\"backgroundColor\":\"\",\"padding\":\"0px\",\"border\":{},\"_meta\":{\"htmlID\":\"u_column_1\",\"htmlClassNames\":\"u_column\"}}}],\"values\":{\"columns\":false,\"backgroundColor\":\"#ffffff\",\"columnsBackgroundColor\":\"\",\"backgroundImage\":{\"url\":\"\",\"fullWidth\":true,\"repeat\":false,\"center\":true,\"cover\":false},\"padding\":\"0px\",\"hideDesktop\":false,\"hideMobile\":false,\"noStackMobile\":false,\"_meta\":{\"htmlID\":\"u_row_1\",\"htmlClassNames\":\"u_row\"},\"selectable\":true,\"draggable\":true,\"deletable\":true}}],\"values\":{\"backgroundColor\":\"#ffffff\",\"backgroundImage\":{\"url\":\"\",\"fullWidth\":true,\"repeat\":false,\"center\":true,\"cover\":false},\"contentWidth\":\"500px\",\"fontFamily\":{\"label\":\"Arial\",\"value\":\"arial,helvetica,sans-serif\"},\"linkStyle\":{\"body\":true,\"linkColor\":\"#0000ee\",\"linkHoverColor\":\"#0000ee\",\"linkUnderline\":true,\"linkHoverUnderline\":true},\"_meta\":{\"htmlID\":\"u_body\",\"htmlClassNames\":\"u_body\"}}}}",
      html: "\n<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\n<head>\n<!--[if gte mso 9]>\n<xml>\n  <o:OfficeDocumentSettings>\n    <o:AllowPNG/>\n    <o:PixelsPerInch>96</o:PixelsPerInch>\n  </o:OfficeDocumentSettings>\n</xml>\n<![endif]-->\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n  <meta name=\"x-apple-disable-message-reformatting\">\n  <!--[if !mso]><!--><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><!--<![endif]-->\n  <title></title>\n  \n    <style type=\"text/css\">\n      a { color: #0000ee; text-decoration: underline; }\nbody {\n  margin: 0;\n  padding: 0;\n}\n\ntable,\ntr,\ntd {\n  vertical-align: top;\n  border-collapse: collapse;\n}\n\np,\nul {\n  margin: 0;\n}\n\n.ie-container table,\n.mso-container table {\n  table-layout: fixed;\n}\n\n* {\n  line-height: inherit;\n}\n\na[x-apple-data-detectors='true'] {\n  color: inherit !important;\n  text-decoration: none !important;\n}\n\n.ExternalClass,\n.ExternalClass p,\n.ExternalClass span,\n.ExternalClass font,\n.ExternalClass td,\n.ExternalClass div {\n  line-height: 100%;\n}\n\n[owa] .email-row .email-col {\n  display: table-cell;\n  float: none !important;\n  vertical-align: top;\n}\n\n.ie-container .email-col-100,\n.ie-container .email-row,\n[owa] .email-col-100,\n[owa] .email-row {\n  width: 500px !important;\n}\n.ie-container .email-col-17,\n[owa] .email-col-17 {\n  width: 85px !important;\n}\n.ie-container .email-col-25,\n[owa] .email-col-25 {\n  width: 125px !important;\n}\n.ie-container .email-col-33,\n[owa] .email-col-33 {\n  width: 165px !important;\n}\n.ie-container .email-col-50,\n[owa] .email-col-50 {\n  width: 250px !important;\n}\n.ie-container .email-col-67,\n[owa] .email-col-67 {\n  width: 335px !important;\n}\n\n@media only screen and (min-width: 520px) {\n  .email-row {\n    width: 500px !important;\n  }\n  .email-row .email-col {\n    vertical-align: top;\n  }\n  .email-row .email-col-100 {\n    width: 500px !important;\n  }\n  .email-row .email-col-67 {\n    width: 335px !important;\n  }\n  .email-row .email-col-50 {\n    width: 250px !important;\n  }\n  .email-row .email-col-33 {\n    width: 165px !important;\n  }\n  .email-row .email-col-25 {\n    width: 125px !important;\n  }\n  .email-row .email-col-17 {\n    width: 85px !important;\n  }\n}\n\n@media (max-width: 520px) {\n  .email-row-container {\n    padding-left: 0px !important;\n    padding-right: 0px !important;\n  }\n  .email-row .email-col {\n    min-width: 320px !important;\n    max-width: 100% !important;\n    display: block !important;\n  }\n  .email-row {\n    width: calc(100% - 40px) !important;\n  }\n  .email-col {\n    width: 100% !important;\n  }\n  .email-col > div {\n    margin: 0 auto;\n  }\n  .no-stack .email-col {\n    min-width: 0 !important;\n    display: table-cell !important;\n  }\n  .no-stack .email-col-50 {\n    width: 50% !important;\n  }\n  .no-stack .email-col-33 {\n    width: 33% !important;\n  }\n  .no-stack .email-col-67 {\n    width: 67% !important;\n  }\n  .no-stack .email-col-25 {\n    width: 25% !important;\n  }\n  .no-stack .email-col-17 {\n    width: 17% !important;\n  }\n}\n\n@media (max-width: 480px) {\n  .hide-mobile {\n    display: none !important;\n    max-height: 0px;\n    overflow: hidden;\n  }\n\n  .full-width-mobile {\n    width: 100% !important;\n    max-width: 100% !important;\n  }\n}\n\n@media (min-width: 980px) {\n  .hide-desktop {\n    display: none !important;\n    max-height: none !important;\n  }\n}\n\n    </style>\n  \n  \n<!--[if mso]>\n<style type=\"text/css\">\n  ul li {\n    list-style:disc inside;\n    mso-special-format:bullet;\n  }\n</style>\n<![endif]-->\n\n</head>\n\n<body class=\"clean-body\" style=\"margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #ffffff\">\n  <!--[if IE]><div class=\"ie-container\"><![endif]-->\n  <!--[if mso]><div class=\"mso-container\"><![endif]-->\n  <table class=\"nl-container\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #ffffff;width:100%\" cellpadding=\"0\" cellspacing=\"0\">\n  <tbody>\n  <tr style=\"vertical-align: top\">\n    <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\n    <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" style=\"background-color: #ffffff;\"><![endif]-->\n    \n\n<div class=\"email-row-container\" style=\"padding: 0px;background-color: #ffffff\">\n  <div style=\"Margin: 0 auto;min-width: 320px;max-width: 500px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\" class=\"email-row\">\n    <div style=\"border-collapse: collapse;display: table;width: 100%;background-color: transparent;\">\n      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: #ffffff;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:500px;\"><tr style=\"background-color: transparent;\"><![endif]-->\n      \n<!--[if (mso)|(IE)]><td align=\"center\" width=\"500\" style=\"width: 500px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\n<div class=\"email-col email-col-100\" style=\"max-width: 320px;min-width: 500px;display: table-cell;vertical-align: top;\">\n  <div style=\"width: 100% !important;\">\n  <!--[if (!mso)&(!IE)]><!--><div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\n  \n<table id=\"u_content_image_1\" class=\"u_content_image\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n  <tbody>\n    <tr>\n      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n        \n<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n  <tr>\n    <td style=\"padding-right: 0px;padding-left: 0px;\" align=\"center\">\n      \n      <img align=\"center\" border=\"0\" src=\"https://via.placeholder.com/500x100?text=REPLACE THIS WITH YOUR LOGO\" alt=\"Image\" title=\"Image\" style=\"outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;clear: both;display: block !important;border: none;height: auto;float: none;width: 100%;max-width: 480px;\" width=\"480\"/>\n      \n    </td>\n  </tr>\n</table>\n\n      </td>\n    </tr>\n  </tbody>\n</table>\n\n<table id=\"u_content_text_1\" class=\"u_content_text\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n  <tbody>\n    <tr>\n      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n        \n  <div style=\"color: #000000; line-height: 140%; text-align: left; word-wrap: break-word;\">\n    <p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\">&nbsp;</p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\">&nbsp;</p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px; text-align: center;\"><strong><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">Hi {{customer.first_name}}&nbsp; {{customer.last_name}} !</span></strong></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\">&nbsp;</p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">A few weeks ago we fulfilled your order of<strong> {{product_name}}</strong>. At {{ shop.shop_name }}, we take out customer satisfaction seriously -&nbsp; if there is an issue with your order, we aim to offer a reasonable solution within 1-2 working days via out support channel ({{ shop.email }})</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\">&nbsp;</p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\">We'd love feedback &amp; testimonials from our past customers to help build trust among new customers. if you are satisfied with our product or customer service so far, we'd greatly appreciate it if you could leave us a positive rating or review.</p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">&nbsp;</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\">Best regards,</span></p>\n<p style=\"background-color: #ffffff; line-height: 140%; font-size: 14px;\"><span style=\"font-family: helvetica, sans-serif; line-height: 19.6px; font-size: 14px;\"><span style=\"text-align: center; line-height: 19.6px; font-size: 14px;\">&nbsp;</span>{{shop.shop_name}}</span></p>\n  </div>\n\n      </td>\n    </tr>\n  </tbody>\n</table>\n\n  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\n  </div>\n</div>\n<!--[if (mso)|(IE)]></td><![endif]-->\n      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\n    </div>\n  </div>\n</div>\n\n\n    <!--[if (mso)|(IE)]></td></tr></table><![endif]-->\n    </td>\n  </tr>\n  </tbody>\n  </table>\n  <!--[if (mso)|(IE)]></div><![endif]-->\n</body>\n\n</html>\n" 
    )
  end

  def api_version
    ShopifyApp.configuration.api_version
  end

  def get_shop_info
    shop_info = ShopifyAPI::Session.temp(domain: shopify_domain, token: shopify_token, api_version: ShopifyApp.configuration.api_version) do
      ShopifyAPI::Shop.current
    end
    shop_info = shop_info.attributes

    self.email = shop_info['email']
    self.address = shop_info['address1']
    if shop_info['shop_owner'].include?(' ')
      self.owner_first_name, self.owner_last_name = shop_info['shop_owner'].split(' ')
    else
      self.owner_first_name = shop_info['shop_owner']
    end
    self.phone = shop_info['phone']
    self.shop_name = shop_info['name']
    self.timezone = shop_info['iana_timezone']
    save
  end

  def create_unique_token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      return (self.web_token = random_token) unless Shop.exists?(web_token: random_token)
    end
  end

end
