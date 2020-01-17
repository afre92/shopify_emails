class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_one :thank_you_template, dependent: :destroy
  after_create :get_shop_info, :associate_templates 

  def associate_templates
    ThankYouTemplate.create(shop_id: self.id)
  end

  def api_version
    ShopifyApp.configuration.api_version
  end

  def get_shop_info
    shop_info = ShopifyAPI::Session.temp(domain: self.shopify_domain, token: self.shopify_token, api_version: ShopifyApp.configuration.api_version) do
      ShopifyAPI::Shop.current()
    end
    shop_info = shop_info.attributes

    self.email = shop_info['email']
    self.address = shop_info['address1']
    self.owner_first_name = shop_info['shop_owner']
    self.phone = shop_info['phone']
    self.shop_name = shop_info['name']
    self.save
  end
end
