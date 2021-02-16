# frozen_string_literal: true

class SettingsController < ShopifyAuthenticatedController
  # include UserPlans
  before_action :find_store

  def edit; end

  def update
    if @shop.update(shop_params)
      flash[:success] = 'Settings updated.'
    else
      flash[:danger] = 'Ooops, something is wrong '
    end
    redirect_to edit_settings_path
  end

  def pricing
    @view = 'pricing'
    @charge_id = @shop.current_charge.id
  end

  def complete_onboarding
    @shop.update_attribute(:onboarding_completed, true)
    redirect_to templates_path
  end

  private

  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @view = 'settings'
  end

  def shop_params
    params.require(:shop).permit(:status, :thank_you_interval, :review_interval, :shop_name, :title, :owner_first_name, :owner_last_name, :phone, :address, :email, :website, :star_color, :form_button_color, :default_link_color, :instagram, :facebook, :twitter, :thank_you_status, :review_status, price_rule_attributes: %i[value value_type active id])
  end
end
