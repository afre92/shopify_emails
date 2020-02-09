# frozen_string_literal: true

class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.datetime :scheduled_time
      t.integer :was_sent, default: 0
      t.integer :tracking_pixel_id
      t.integer :template_id
      t.integer :shop_id
      t.integer :order_id

      t.timestamps
    end
  end
end
