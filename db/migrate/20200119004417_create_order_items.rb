# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.string :shopify_id
      t.string :variant_id
      t.string :title
      t.integer :quantity
      t.integer :order_id
      t.integer :number

      t.timestamps
    end
  end
end
