class AddOtherFieldsToShop < ActiveRecord::Migration[5.2]
  def change
  	add_column :shops, :email, :string, default: ''
  	add_column :shops, :subscription_type, :integer, default: 0
  	add_column :shops, :tokens, :float, default: 10.0
  end
end
