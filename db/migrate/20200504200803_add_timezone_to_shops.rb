class AddTimezoneToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :timezone, :string, default: '(GMT-05:00) Eastern Time'
  end
end
