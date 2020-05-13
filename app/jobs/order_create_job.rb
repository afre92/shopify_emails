# frozen_string_literal: true
require "securerandom"
require 'nokogiri'

class OrderCreateJob < ActiveJob::Base

  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)
    return unless shop.status == 1

    # Create Order
    order = shop.orders.build
    order.shopify_id = webhook['id'].to_s
    order.order_number = webhook['order_number']
    order.email = webhook['email']
    order.shopify_created_at = webhook['created_at']
    order.customer = webhook['customer'].to_json
    order.save

    # Create Thank You Email
    thank_you_email = order.emails.build({shop: shop, order: order, email_type: 'thank_you'})
    thank_you_email.add_delivery_data
    if thank_you_email.save
      puts "Thank you email for Order:#{order.id} SUCCESSFULLY created"
    else
      puts "Thank you email for Order:#{order.id} COULD NOT BE created"
    end

    # Create Order Items and Review Email if subscription_type != 'free'
    if shop.subscription_type != "free"

      webhook['line_items'].each do |item|
        # next if order.find_by(shopify_id: item['id'].to_s).present?
        order_item = order.order_items.build
        order_item.shopify_id = item['id'].to_s
        order_item.variant_id = item['variant_id'].to_s
        order_item.title = item['title']
        order_item.quantity = item['quantity']
        order_item.save
      end

      # Create Review Email
      review_email = order.emails.build({shop: shop, order: order, email_type: 'review'})
      review_email.add_delivery_data
      if review_email.save
        puts "Review email for Order:#{order.id} SUCCESSFULLY created."
      else
        puts "Review email for Order:#{order.id} COULD NOT BE created."
      end

    end

    shop.with_shopify_session do
    end
  end
end
