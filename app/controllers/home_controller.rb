# frozen_string_literal: true

class HomeController < AuthenticatedController
  include UserPlans
  before_action :find_shop
  before_action :set_daterange, only: :index

  def index
    redirect_to onboarding_path unless @shop.onboarding_completed
    @emails_sent = @shop.emails_sent(@daterange)
    @emails_opened = @shop.emails_opened(@daterange)
    @emails_used = @shop.emails_sent(DateTime.now.beginning_of_month...DateTime.now.end_of_month)
    @email_limit = (@emails_used + @shop.tokens).round
    email_graph_data

    # price_rule = nil
    # session = ShopifyAPI::Session.new(domain: @shop.shopify_domain, token: @shop.shopify_token, api_version: ShopifyApp.configuration.api_version) #do
    # ShopifyAPI::Base.activate_session(session)
      # price_rule = ShopifyAPI::PriceRule.new("title": 'ReviewReward', "target_type": "line_item", "target_selection": "all","allocation_method": "across","value_type": "fixed_amount","value": "-10.0","customer_selection": "all","starts_at": Time.now.iso8601)
      # @price_rule = ShopifyAPI::PriceRule.new(
      #   title: "CrumbDiscount2",
      #   target_type: "line_item",
      #   target_selection: "all",
      #   allocation_method: "across",
      #   value_type: "percentage",
      #   value: "-20.0",
      #   customer_selection: "all",
      #   starts_at: Time.now.iso8601, 
      # )
      byebug
      # @price_rule.save

    # end

    # byebug
  end

  def onboarding
    render layout: false
  end

  def email_graph_data
    @graph_data = {}
    @daterange.each do |date|
      @graph_data[date.strftime('%m/%d')] = [@shop.emails.sent.where(created_at: date...date.end_of_day).count, @shop.emails.where(created_at: date...date.end_of_day).sent.opened]
    end
    return @graph_data
  end

  private

  def find_shop
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @view = 'dashboard'
  end
end
