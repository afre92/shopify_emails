class PriceRule < ApplicationRecord
  belongs_to :shop
  # has_many :discount_codes, dependent: :destroy
  before_save :handle_before_save

  enum value_type: { fixed_amount: 0, percentage: 1}


  def handle_before_save
    self.value = "-#{value}"
  end
end
