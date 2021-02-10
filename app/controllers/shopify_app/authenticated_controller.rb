# frozen_string_literal: true

module ShopifyApp
  class ShopifyAuthenticatedController < ActionController::Base
    include ShopifyApp::Authenticated

    protect_from_forgery with: :exception
  end
end
