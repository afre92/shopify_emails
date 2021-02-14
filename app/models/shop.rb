# frozen_string_literal: true

class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  
  has_many :templates, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_many :reviews, through: :orders
  has_many :charges
  has_one  :price_rule, dependent: :destroy
  accepts_nested_attributes_for :price_rule

  before_create :create_unique_token
  after_create  :handle_after_create

  enum subscription_type: { free: 0, basic: 1, pro: 2 }

  def handle_after_create
    ShopifyAPI::Session.temp(domain: shopify_domain, token: shopify_token, api_version: ShopifyApp.configuration.api_version) do
      get_shop_info
      create_price_rule
      create_script_tag
    end

    create_templates
    create_default_dataset
    create_default_charge
  end

  def create_script_tag
    ShopifyAPI::ScriptTag.create(event: 'onload', src: "#{ENV['NON_E']}product.js")
  end

  def current_charge
    return self.charges.order('created_at').where(active: true).last
  end

  def add_reviews_images_modal
    # get access to link
    themes = ShopifyAPI::Theme.all

    themes.each do |theme|
      if theme.attributes['role'] == 'main'
        update_attribute(:theme_id, themes.first.attributes['id'])
      end
    end

    layout        = ShopifyAPI::Asset.find('layout/theme.liquid', params: { theme_id: theme_id })
    parsed_layout = Nokogiri::HTML(layout.value)
    body          = parsed_layout.at_css 'body'
    template       = '<div class="ue-review-images-modal" style="display: none;">
    <div>
      <div class="close ue-trigger"></div>
      <div class="ue-modal-content"></div>
    </div>
  </div>'

    body.add_next_sibling(template)
  end

  def create_price_rule
    price_rule = ShopifyAPI::PriceRule.new(
      title:              'REVIEWCOLLECTOR',
      target_type:        'line_item',
      target_selection:   'all',
      allocation_method:  'across',
      value_type:         'fixed_amount',
      value:              '-10.0',
      once_per_customer:  true,
      customer_selection: 'all',
      starts_at:          Time.now.iso8601
    )

    if price_rule.save
      # create price rule in local db
      local_price_rule = build_price_rule(
        title:       price_rule.title,
        value:       price_rule.value,
        value_type:  price_rule.value_type,
        starts_at:   price_rule.starts_at,
        shopify_id:  price_rule.id.to_s
      )
      local_price_rule.save
    end
  end

  def create_templates
    # Create Thank You Template
    Template.create(
      shop_id:        id,
      from:           email,
      reply_to:       email,
      subject:        'I really want to send you a special thanks for visiting our store',
      template_type:  'thank_you',
      body:           'test',
      html:           'test'
    )

    # Create Review Template
    Template.create(
      shop_id:       id,
      from:          email,
      reply_to:      email,
      subject:       "We'd love feedback on your recent #{shop_name} purchase",
      template_type: 'review',
      body:          'test',
      html:          'test'
    )
  end

  # Creates sample dataset used to preview emails
  def create_default_dataset
    order                    = orders.new
    order.shopify_id         = '000'
    order.email              = 'info@example.com'
    order.shopify_created_at = DateTime.now
    order.customer           = '{"id":2871225188422,"email":"info@example.com","accepts_marketing":false,"created_at":"2020-04-02T18:01:37-04:00","updated_at":"2020-05-13T19:25:28-04:00","first_name":"John","last_name":"Smith","orders_count":0,"state":"disabled","total_spent":"0.00","last_order_id":null,"note":null,"verified_email":true,"multipass_identifier":null,"tax_exempt":false,"phone":null,"tags":"","last_order_name":null,"currency":"USD","accepts_marketing_updated_at":"2020-04-02T18:01:38-04:00","marketing_opt_in_level":null,"admin_graphql_api_id":"gid://shopify/Customer/2871225188422","default_address":{"id":3077169905734,"customer_id":2871225188422,"first_name":"John","last_name":"Smith","company":null,"address1":"123 Main St ","address2":"","city":"Miami","province":"Florida","country":"United States","zip":"33137","phone":null,"name":"John Smith","province_code":"FL","country_code":"US","country_name":"United States","default":true}}'
    order.order_number       = '1000'
    order.save

    2.times do |t|
      order_item = order.order_items.new(shopify_id: '000', title: "Test Product ##{t + 1}")
      order_item.save
    end
  end

  def get_shop_info
    shop_info     = ShopifyAPI::Shop.current.attributes
    self.email    = shop_info['email']
    self.address  = shop_info['address1']
    if shop_info['shop_owner'].include?(' ')
      self.owner_first_name, self.owner_last_name = shop_info['shop_owner'].split(' ')
    else
      self.owner_first_name = shop_info['shop_owner']
    end
    self.website    = shopify_domain
    self.phone      = shop_info['phone']
    self.shop_name  = shop_info['name']
    self.timezone   = shop_info['iana_timezone']
    save
  end

  def create_unique_token
    random_token = SecureRandom.urlsafe_base64(nil, false)
    self.web_token = random_token
  end

  def api_version
    ShopifyApp.configuration.api_version
  end

  def sample_order
    orders.find_by(shopify_id: '000', order_number: '1000')
  end

  def emails_sent(daterange)
    emails.sent.where(created_at: daterange).count
  end

  def emails_opened(daterange)
    emails.where(created_at: daterange).sent.opened
  end


  # Use new json file with the prices here
  def create_default_charge
    plan_info = Charge.get_subscriptions_info('free')

    self.charges.create(payment_status:     1, 
                        shopify_charge_id:  '000000', 
                        billing_on:         Date.today.day,
                        subscription_type:  'free',
                        tokens:             plan_info["number_of_tokens"],
                        active:             true
                        )
  end



  ###################### METHODS FROM NON-EMBEDDED ######################

  def temp_session(*args)
    ShopifyAPI::Session.temp(domain: self.shopify_domain, token: self.shopify_token, api_version: '2019-10') do
      args.each do |arg|
        return method(arg).call
      end
    end
  end

end
