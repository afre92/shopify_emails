class AddTimezoneToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :timezone, :string, default: 'America/New_York'
  end
end
