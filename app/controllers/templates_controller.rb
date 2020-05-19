# frozen_string_literal: true


class TemplatesController < AuthenticatedController
  before_action :find_store  

  def index
    set_token
    order = @shop.orders.find_by(shopify_id: '000', order_number: '000')
    @thank_you_email = order.emails.build({order: order, email_type: 'thank_you'})
    @review_email = order.emails.build({order: order, email_type: 'review'})
  end

  def edit
    @template = @shop.templates.first
  end

  def set_token
    shop_token = @shop.web_token+Date.current.month.to_s
    @token = Digest::SHA2.hexdigest shop_token
  end

  private

  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @view = 'templates'
  end
end
