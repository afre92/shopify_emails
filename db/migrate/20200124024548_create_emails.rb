# frozen_string_literal: true

class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.datetime :scheduled_time
      t.integer :was_sent, default: 0
      t.integer :tracking_pixel_id
      t.text :html
      t.belongs_to :template
      t.belongs_to :shop
      t.belongs_to :order

      t.timestamps
    end
  end
end
