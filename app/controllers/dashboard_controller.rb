# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :find_shop

  def index
    # @daterange = # ? params[:daterange] : ""
    @daterange = params[:daterange] ? format_daterange(params[:daterange]) : (DateTime.now.beginning_of_month...DateTime.now)
    @emails_sent = @shop.emails.sent.where(created_at: @daterange).count
    @emails_used = @shop.emails.count
    @emails_opened = @shop.emails.where(created_at: @daterange).sent.opened
  end

  def format_daterange(daterange)
    from, to = daterange.split('-')
    (DateTime.strptime(from.remove(' '), '%m/%d/%Y')...DateTime.strptime(to.remove(' '), '%m/%d/%Y'))
  end

  private

  def find_shop
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @controller = params[:controller]
  end
end
