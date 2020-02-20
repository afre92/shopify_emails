# frozen_string_literal: true

class TemplatesController < AuthenticatedController
  before_action :find_store
  

  def index
    byebug
    @thank_you_template = @shop.templates.first
  end

  def edit
    @template = @shop.templates.first
  end

  def update
    byebug
  end

  def set_token
    shop_token = @shop.web_token+Date.current.month
    @token = Digest::SHA2.hexdigest shop_token
  end

  private

  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @controller = params[:controller]
  end
end
