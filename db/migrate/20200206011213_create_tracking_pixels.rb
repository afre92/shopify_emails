# frozen_string_literal: true

class CreateTrackingPixels < ActiveRecord::Migration[5.2]
  def change
    create_table :tracking_pixels do |t|
      t.belongs_to :template
      t.belongs_to :shop
      t.belongs_to :email
      t.string :token
      t.integer :views, default: 0

      t.timestamps
    end
  end
end
