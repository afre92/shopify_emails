# frozen_string_literal: true
require 'nokogiri'


class TemplatesController < AuthenticatedController
  before_action :find_store
  before_action :create_data_for_template, only: [:index]
  

  def index
    set_token

    @thank_you_template = @shop.templates.find_by(template_type: 'thank_you')
    @review_template = @shop.templates.find_by(template_type: 'review')
    # todo find better make this and use it also in the job 
    review_html = Nokogiri::HTML(@review_template.html)
    div = review_html.css('div.email-row-container').last
    # create order and children and grand children to pass to review form
    new_order = Order.new
    new_order.order_items.new.build_review
    review_form = view_context.render partial: 'templates/review_form.html.erb', locals: { order: @order, shop: @shop }
    div.add_next_sibling(review_form)
    
    @review_template.html = review_html
  end


  def create_data_for_template
    @order = Order.new
    3.times do |i|
      @order.order_items.new(title: "#{i} times").build_review
    end

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
