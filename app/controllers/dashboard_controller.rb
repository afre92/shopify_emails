# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :find_shop

  def index
    @emails_sent = @shop.emails.sent.count
    @emails_used = @shop.emails.count
    @emails_opened = @shop.emails.sent.opened
  end

    private 
    
    def find_shop
      @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    end
end
