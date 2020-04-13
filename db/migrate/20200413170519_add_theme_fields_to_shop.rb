class AddThemeFieldsToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :star_color, :string, default: '#ffd700'
    add_column :shops, :form_button_color, :string, default: '#1775EF'
    add_column :shops, :default_link_color, :string, default: '#7db6ff'
    add_column :shops, :instagram, :string, default: ''
    add_column :shops , :facebook, :string, default: ''
    add_column :shops, :twitter, :string, default: ''
  end
end
