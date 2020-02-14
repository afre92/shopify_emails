# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :find_shop

  def index
    @daterange = params[:daterange] ? format_daterange(params[:daterange]) : (DateTime.now.beginning_of_month...DateTime.now)
    @emails_sent = @shop.emails.sent.where(created_at: @daterange).count
    @emails_used = @shop.emails.count
    @emails_opened = @shop.emails.where(created_at: @daterange).sent.opened
    email_graph_data
  end

  def format_daterange(daterange)
    from, to = daterange.split('-')
    (DateTime.strptime(from.remove(' '), '%m/%d/%Y')...DateTime.strptime(to.remove(' '), '%m/%d/%Y'))
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
    @controller = params[:controller]
  end
end
