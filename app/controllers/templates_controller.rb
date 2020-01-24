class TemplatesController < ApplicationController
  before_action :find_store
  def index
    @thank_you_template = @shop.templates.first
  end

  def edit
    @template = @shop.templates.first
  end

  def update
    byebug
  end

  private
    def find_store
      @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    end
end
