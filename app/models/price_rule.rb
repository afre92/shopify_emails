class PriceRule < ApplicationRecord
  belongs_to :shop

  enum value_type: { fixed_amount: 0, percentage: 1}
end
