class SettingsController < ApplicationController
  before_action :find_store, only: [:edit]

  def edit
    
  end

  def update
  byebug
  end

  private
    def find_store
      @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    end

end
