# frozen_string_literal: true

class SettingsController < AuthenticatedController
  include UserPlans
  before_action :find_store

  def edit 

  end

  def update
    if @shop.update(shop_params)
      flash[:success] = "Settings updated successfully."
    else
      flash[:danger] = "Ooops, something is wrong "
    end
    redirect_to settings_path
  end

  def pricing
  end

  # Move shopify related code to module helper

  def cancel_charge
    ShopifyAPI::RecurringApplicationCharge.current.cancel
    @shop.update(subscription_type: 'free')
    redirect_to settings_path
  end

  def create_recurring_application_charge
    #change current plan and move around token if present
      ShopifyAPI::RecurringApplicationCharge.current &&
        ShopifyAPI::RecurringApplicationCharge.current.cancel
      
      # if not accepted then is the current application charge deleted ?
      @plan_id = params[:id]
      plan_info = get_plan(@plan_id)
      recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(
        name: plan_info[:name],
        price: plan_info[:price],
        return_url: "#{ENV['APP_URL']}/activatecharge",
        test: plan_info[:test],
        capped_amount: plan_info[:capped_amount],
        terms: plan_info[:terms]
      )
      if recurring_application_charge.save
        
        return @url = recurring_application_charge.confirmation_url
        
      else
        # recurring charge could no be created
      end
   end
  
  def activate_charge
    redirect_link = "https://#{@shop.shopify_domain}/admin/apps/#{ENV['APP_NAME']}/pricing"
    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(request.params['charge_id'])
    # should I check for current plan before? if so should I cancel the current plan?
    if recurring_application_charge.status == "accepted" 
       recurring_application_charge.activate
        #  if subscriptiom upgrade addition of emails sent will go here
       if recurring_application_charge.name == "Pro plan"
        @shop.update(subscription_type: 2)
       else
        @shop.update(subscription_type: 1)
       end
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
