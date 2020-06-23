class AddOrderItemToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :exported, :boolean, default: false
    add_reference :reviews, :order_item, foreign_key: true
    add_column :reviews, :uuid, :string, default: ''
  end
end
