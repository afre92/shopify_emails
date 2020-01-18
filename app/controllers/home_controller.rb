# frozen_string_literal: true

class HomeController < AuthenticatedController
  before_action :find_store, only: [:templates]

  def show
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
  end

  def templates
    @thank_you_template = @shop.thank_you_template
  end

  private

    def find_store
      @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    end

end
