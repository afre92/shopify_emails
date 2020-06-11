class AddThemeFieldsToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :star_color, :string, default: '#ffd700'
    add_column :shops, :form_button_color, :string, default: '#1775EF'
    add_column :shops, :default_link_color, :string, default: '#7db6ff'
    add_column :shops, :instagram, :string, default: 'https://www.instagram.com/'
    add_column :shops , :facebook, :string, default: 'https://www.facebook.com/'
    add_column :shops, :twitter, :string, default: 'https://twitter.com/'
    add_column :shops, :onboarding_completed, :boolean, default: false
    add_column :shops, :timezone, :string, default: 'America/New_York'
  end
end
