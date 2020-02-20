# frozen_string_literal: true

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

  def set_token
    # shop_token = @shop
    @token = Digest::SHA2.hexdigest 'abc'
  end

  private

  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @controller = params[:controller]
  end
end
