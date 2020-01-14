class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :templates
  after_create :associate_templates

  def associate_templates
    ThankYouTemplate.create(shop_id: self.id)
  end
  def api_version
    ShopifyApp.configuration.api_version
  end

end
