# frozen_string_literal: true

class HomeController < AuthenticatedController
  before_action :find_shop
  before_action :set_daterange, only: :index

  def index
    @emails_sent = @shop.emails_sent(@daterange)
    @emails_opened = @shop.emails_opened(@daterange)
    @emails_used = @shop.emails.count
    email_graph_data
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
