class AddMoreFieldsToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :shopify_product_id, :string
    add_column :reviews, :customer_name, :string
  end
end
