class CreateDiscountCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_codes do |t|
      t.string :code
      t.belongs_to :shop
      t.belongs_to :price_rule

      t.timestamps
    end
  end
end
