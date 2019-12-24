class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_one :template

  def api_version
    ShopifyApp.configuration.api_version
  end

end
