class AddOrderStatusUrlToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_status_url, :string, default: ''
    add_column :reviews, :submitted_on, :datetime
  end
end
