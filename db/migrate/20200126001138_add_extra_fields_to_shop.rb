# frozen_string_literal: true

class AddExtraFieldsToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :review_interval, :integer, default: 10
    add_column :shops, :thank_you_interval, :integer, default: 10
    add_column :shops, :status, :integer, default: 0
  end
end
