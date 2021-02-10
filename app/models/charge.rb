class Charge < ApplicationRecord
  belongs_to :shop
  after_create :deactivate_previous_charge

  def self.get_subscriptions_info(plan_name = 'all')
    data_hast = File.read(File.expand_path('config/subscriptions_details.json'))
    if plan_name == "all"
      return JSON.parse(data_hast)
    else
      return JSON.parse(data_hast)[plan_name]
    end
  end


  def deactivate_previous_charge
    shop             = Shop.find(self.shop_id)
    previous_charge  = shop.charges.last(2).first
    previous_charge.update(active: false)
  end

end
