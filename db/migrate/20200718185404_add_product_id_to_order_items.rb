class AddProductIdToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :shopify_product_id, :string
  end
end
