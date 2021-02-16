# frozen_string_literal: true

class HomeController < ShopifyAuthenticatedController
  # include UserPlans
  before_action :find_shop
  before_action :set_daterange, only: :index

  def index
    # redirect_to onboarding_path unless @shop.onboarding_completed
    @emails_sent = @shop.emails_sent(@daterange)
    @emails_opened = @shop.emails_opened(@daterange)
    @emails_used = @shop.emails_sent(DateTime.now.beginning_of_month...DateTime.now.end_of_month)
    @email_limit = (@emails_used + @shop.tokens).round
    email_graph_data
  end

  def onboarding
    render layout: false
  end

  def email_graph_data
    @graph_data = {}
    @daterange.each do |date|
      @graph_data[date.strftime('%m/%d')] = [@shop.emails.sent.where(created_at: date...date.end_of_day).count, @shop.emails.where(created_at: date...date.end_of_day).sent.opened]
    end
    @graph_data
  end

  private

  def find_shop
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @view = 'dashboard'
  end
end
