# frozen_string_literal: true

class SettingsController < AuthenticatedController
  before_action :find_store

  def edit; end

  def update
    @shop.update(shop_params)
  end

  def create_recurring_application_charge
    unless ShopifyAPI::RecurringApplicationCharge.current
      recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(
              name: "Basic plan",
              price: 9.99,
              return_url: "#{ENV['APP_URL']}activatecharge",
              test: true,
              trial_days: 7,
              capped_amount: 100,
              terms: "$0.99 for every order created")
   
      if recurring_application_charge.save
        # @tokens[:confirmation_url] = recurring_application_charge.confirmation_url
        # byebug
      @url = recurring_application_charge.confirmation_url
      end
    end
   end
  
  def activate_charge
    byebug
    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(request.params['charge_id'])
    recurring_application_charge.status == "accepted" ? recurring_application_charge.activate : redirect_to('https://test-email-thing.myshopify.com/admin/apps')

    redirect_to 'https://test-email-thing.myshopify.com/admin/apps'
  end

  private

  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @controller = params[:controller]
  end

  def shop_params
    params.require(:shop).permit(:status, :thank_you_interval, :review_interval, :shop_name, :title, :owner_first_name, :owner_last_name, :phone, :address, :email, :website)
  end
end
