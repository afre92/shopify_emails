class OrderCreateJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)

    return unless shop.status == 1

    # Create Order for Thank You Email
    new_order = Order.new
    new_order.shopify_id = webhook['id'].to_s
    new_order.email = webhook['email']
    new_order.shopify_created_at = webhook['created_at']
    new_order.shop_id = shop.id
    new_order.customer = webhook['customer'].to_json
    new_order.save

    # Create Thank You Email
    thank_you_email = Email.new 
    thank_you_email.scheduled_time = new_order.shopify_created_at + shop.thank_you_interval.minutes
    thank_you_email.template_id = shop.templates.find_by(template_type: 0).id
    thank_you_email.html = shop.templates.find_by(template_type: 0).html
    thank_you_email.shop_id = shop.id
    thank_you_email.order_id = new_order.id
    thank_you_email.save

    # Create Order Items and Review Email if subscription_type == 1
    if shop.subscription_type == 1

      webhook['line_items'].each do |item|
        new_order_item = OrderItem.new
        new_order_item.shopify_id = item['id'].to_s
        new_order_item.variant_id = item['variant_id'].to_s
        new_order_item.title = item['title']
        new_order_item.quantity = item['quantity']
        new_order_item.order_id = new_order.id
        new_order_item.save
      end

      # Create Review Email
      review_email = Email.new 
      review_email.scheduled_time = new_order.shopify_created_at + shop.review_interval.days
      review_email.template_id = shop.templates.find_by(template_type: 1).id
      review_email.html = shop.templates.find_by(template_type: 1).html
      review_email.shop_id = shop.id
      review_email.order_id = new_order.id
      review_email.save

    end


    shop.with_shopify_session do
    end
  end
end
