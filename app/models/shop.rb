class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_one :thank_you_template
  after_create :associate_templates

  def associate_templates
    ThankYouTemplate.create(shop_id: self.id)
  end
  def api_version
    ShopifyApp.configuration.api_version
  end

end
