class AddWebTokenToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :web_token, :string
  end
end
