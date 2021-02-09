class Charge < ApplicationRecord
  belongs_to :shop

  def self.get_subscriptions_info(plan_name = 'all')
    data_hast = File.read(File.expand_path('config/subscriptions_details.json'))

    if plan_name == "all"
      return JSON.parse(data_hast)
    else
      return JSON.parse(data_hast)[plan_name]
    end
  end

end
