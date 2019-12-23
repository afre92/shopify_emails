class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  after_create :add_email

  def api_version
    ShopifyApp.configuration.api_version
  end

  def add_email
  	byebug
  end
end
