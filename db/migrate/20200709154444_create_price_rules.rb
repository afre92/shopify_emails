class CreatePriceRules < ActiveRecord::Migration[5.2]
  def change
    create_table :price_rules do |t|
      t.belongs_to :shop
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :active
      t.string :title
      t.integer :value
      t.integer :value_type

      t.timestamps
    end
  end
end
