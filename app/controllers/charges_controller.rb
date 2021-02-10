class ChargesController < ShopifyAuthenticatedController
  before_action :find_store, :init_subscriptions_info

  def create_local_charge_only
    ShopifyAPI::RecurringApplicationCharge.current.cancel
    @shop.charges.create(
                          payment_status:     1, 
                          shopify_charge_id:  "000000", 
                          billing_on:         Date.today.day,
                          subscription_type:  "free",
                          tokens:             100,
                          active:             true
                          )
  
    flash[:success] = 'Your plan has been changed to Free.'
    fullpage_redirect_to "https://#{@shop.shopify_domain}/admin/apps/#{ENV['APP_NAME']}/embedded/pricing"
  end

  # TODO: maybe change it so the free plan creates a new Shopify charge but charging $0.00 instead of using create_local_charge_only method
  def create
    # Each shop can have only one recurring charge per app. When a new recurring application charge is activated for a shop
    # that already has one, the existing recurring charge is canceled and replaced by the new charge.
    # The new recurring charge is then activated.

    plan_info      = @subscriptions_info[params[:subscription_type]]
    local_charge   = @shop.charges.create

    shopify_charge = ShopifyAPI::RecurringApplicationCharge.new(
      name:           plan_info["name"],
      price:          plan_info["price"],
      return_url:     "#{ENV['APP_URL']}/charges/#{local_charge.id}/activate",
      test:           plan_info["test"],
      capped_amount:  plan_info["capped_amount"],
      terms:          plan_info["terms"]
    )
    if shopify_charge.save
      fullpage_redirect_to shopify_charge.confirmation_url
    else
      # make sure this works
      local_charge.delete
      # recurring charge could not be created
    end
   end

  def activate
    # might need to save the charge id to check on its status
    local_charge    = @shop.charges.find(request.params["local_charge_id"])
    redirect_link   = "https://#{@shop.shopify_domain}/admin/apps/#{ENV['APP_NAME']}/embedded/pricing"
    shopify_charge  = ShopifyAPI::RecurringApplicationCharge.find(request.params['charge_id'])

    if shopify_charge.status == "accepted"
      plan_info = @subscriptions_info[shopify_charge.name.downcase]
      shopify_charge.activate

      local_charge.update(payment_status:     1, 
                          shopify_charge_id:  request.params["charge_id"], 
                          billing_on:         shopify_charge.billing_on.to_date.day,
                          subscription_type:  shopify_charge.name.downcase,
                          tokens:             plan_info["number_of_tokens"],
                          active:             true
                          )

      @shop.update(tokens: @shop.tokens + plan_info["number_of_tokens"])
      flash[:success] = "Your plan has been changed to #{shopify_charge.name}."
    else
      flash[:danger]  = 'Something is not quite right! plase contact the support team.'
    end
    redirect_to redirect_link
  end

  private

    def find_store
      @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
      @view = 'settings'
    end

    def charge_params
      params.require(:charge).permit(:shopify_charge_id, :shop_id)
    end

    def init_subscriptions_info
      @subscriptions_info = Charge.get_subscriptions_info
    end

end
