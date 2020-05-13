# frozen_string_literal: true
require "securerandom"
require 'nokogiri'

class OrderCreateJob < ActiveJob::Base

  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)

    return unless shop.status == 1

    # Create Order
    new_order = Order.new
    new_order.shopify_id = webhook['id'].to_s
    new_order.order_number = webhook['order_number']
    new_order.email = webhook['email']
    new_order.shopify_created_at = webhook['created_at']
    new_order.shop_id = shop.id
    new_order.customer = webhook['customer'].to_json
    new_order.save

    thank_you_email = new_order.emails.build({shop: Shop.last, order: Order.last, email_type: 'thank_you'})
    thank_you_email.add_delivery_data
    if thank_you_email.save
      puts "Thank you email for Order:#{new_order.id} SUCCESSFULLY created"
    else
      puts "Thank you email for Order:#{new_order.id} COULD NOT BE created"
    end

    # Create Order Items and Review Email if subscription_type != 'free'
    if shop.subscription_type != "free"

      webhook['line_items'].each do |item|
        # next if new_order.find_by(shopify_id: item['id'].to_s).present?
        new_order_item = OrderItem.new
        new_order_item.shopify_id = item['id'].to_s
        new_order_item.variant_id = item['variant_id'].to_s
        new_order_item.title = item['title']
        new_order_item.quantity = item['quantity']
        new_order_item.order_id = new_order.id
        new_order_item.save
      end

      # Create Review Email
      review_email = new_order.emails.build({shop: Shop.last, order: Order.last, email_type: 'review'})
      review_email.add_delivery_data
      if review_email.save
        puts "Review email for Order:#{new_order.id} SUCCESSFULLY created."
      else
        puts "Review email for Order:#{new_order.id} COULD NOT BE created."
      end

    end

    shop.with_shopify_session do
    end
  end
end
