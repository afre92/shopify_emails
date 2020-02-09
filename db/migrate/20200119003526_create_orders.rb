# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :shopify_id
      t.string :email
      t.datetime :shopify_created_at
      t.integer :shop_id
      t.jsonb :customer

      t.timestamps
    end
  end
end
