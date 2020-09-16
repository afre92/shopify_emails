# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  has_one :review, dependent: :destroy

  after_create :create_review_obj

  def create_review_obj
    review = build_review
    review.shopify_product_id = shopify_product_id
    review.customer_name = order.customer_obj.full_name
    review.uuid = SecureRandom.uuid
    review.save
  end
end
