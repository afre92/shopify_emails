# frozen_string_literal: true

class AddOtherFieldsToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :email, :string, default: ''
    add_column :shops, :subscription_type, :integer, default: 0
    add_column :shops, :tokens, :float, default: 10.0
    add_column :shops, :address, :string, default: ''
    add_column :shops, :owner_first_name, :string, default: ''
    add_column :shops, :owner_last_name, :string, default: ''
    add_column :shops, :phone, :string, default: ''
    add_column :shops, :shop_name, :string, default: ''
    add_column :shops, :title, :string, default: 'Founder'
    add_column :shops, :website, :string, default: ''
  end
end
