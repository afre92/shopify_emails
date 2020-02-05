class SettingsController < ApplicationController
  before_action :find_store

  def edit
    
  end

  def update
    @shop.update(shop_params)
  end

  private

    def find_store
      @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    end

    def shop_params
      params.require(:shop).permit(:status, :thank_you_interval, :review_interval, :shop_name, :title, :owner_first_name, :owner_last_name, :phone, :address, :email, :website)
    end

end
