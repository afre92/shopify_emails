class OrderCreateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)

    new_order = Order.new
    new_order.shopify_id = webhook['id']
    new_order.email = webhook['email']
    new_order.shopify_created_at = webhook['created_at']
    new_order.shop_id = shop.id
    new_order.customer = webhook['customer'].to_json
    new_order.save

    webhook['line_items'].each do |item|
      new_order_item = OrderItem.new
      new_order_item.shopify_id = item['id']
      new_order_item.variant_id = item['variant_id']
      new_order_item.title = item['title']
      new_order_item.quantity = item['quantity']
      new_order_item.order_id = new_order.id
      new_order_item.save
    end

    shop.with_shopify_session do
    end
  end
end
