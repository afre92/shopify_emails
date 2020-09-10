class AddThemeIdToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :theme_id, :string
  end
end
