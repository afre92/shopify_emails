# frozen_string_literal: true

class SettingsController < AuthenticatedController
  before_action :find_store

  def edit; end

  def update
    @shop.update(shop_params)
  end

  def remove_plan

  end

  def cancel_charge
    # check for the presence of current
    if ShopifyAPI::RecurringApplicationCharge.current.cancel
      #change subscription_type
    end
  end

  def create_recurring_application_charge
    unless ShopifyAPI::RecurringApplicationCharge.current
      recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(
              name: "Basic plan",
              price: 9.99,
              return_url: "#{ENV['APP_URL']}/activatecharge",
              test: true,
              trial_days: 7,
              capped_amount: 100,
              terms: "$0.99 for every order created")
   
      if recurring_application_charge.save
        @url = recurring_application_charge.confirmation_url
      else
        # recurring charge could no be created
      end
    end
   end
  
  def activate_charge
    # TODO: redirect back original page
    redirect_link = "https://#{@shop.shopify_domain}/admin/apps"
    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(request.params['charge_id'])
    if recurring_application_charge.status == "accepted" 
       recurring_application_charge.activate
       @shop.update(subscription_type: 1)
    else
      # soemthing went wrong
       redirect_to redirect_link
    end
    #something right
    redirect_to redirect_link
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
