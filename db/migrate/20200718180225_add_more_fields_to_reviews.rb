class AddMoreFieldsToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :order_item_shopify_id, :string
    add_column :reviews, :customer_name, :string
  end
end
