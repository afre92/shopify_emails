class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.bigint :shopify_id
      t.bigint :variant_id
      t.string :title
      t.integer :quantity
      t.integer :order_id

      t.timestamps
    end
  end
end
