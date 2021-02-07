class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.integer :billing_on
      t.string :subscription_type, default: 'free'
      t.integer :tokens
      t.boolean :active, default: false
      t.string :shopify_charge_id
      t.belongs_to :shop
      t.timestamps
    end
  end
end
