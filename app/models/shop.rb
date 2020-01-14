class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :templates

  def api_version
    ShopifyApp.configuration.api_version
  end

end
