class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.string :shopify_charge_id
      t.belongs_to :shop
      t.timestamps
    end
  end
end
