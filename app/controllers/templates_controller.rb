# frozen_string_literal: true
require 'nokogiri'


class TemplatesController < AuthenticatedController
  before_action :find_store
  

  def index
    set_token

    @thank_you_template = @shop.templates.find_by(template_type: 'thank_you')
    @review_template = @shop.templates.find_by(template_type: 'review')

    html_doc = Nokogiri::HTML(@review_template.html)
    review_t = html_doc.css('div.email-row-container div.email-row').first
    review_form = view_context.render 'templates/review_form.html.erb'
    @review_template.html = review_t << review_form
  end

  def edit
    @template = @shop.templates.first
  end

  def update
    byebug
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
