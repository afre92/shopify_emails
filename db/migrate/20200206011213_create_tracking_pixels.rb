class CreateTrackingPixels < ActiveRecord::Migration[5.2]
  def change
    create_table :tracking_pixels do |t|
      t.integer :template_id
      t.integer :shop_id
      t.integer :email_id
      t.string :token
      t.integer :views

      t.timestamps
    end
  end
end
