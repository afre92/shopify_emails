class ThankYouTemplateController < ApplicationController
  before_action :find_store
  def index
  end

  def edit
    @template = @shop.thank_you_template
  end

  def update
    byebug
  end

  private
    def find_store
      @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    end
end
