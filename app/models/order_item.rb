# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  validates_presence_of :order_id
  has_one :review, dependent: :destroy

  after_create :create_review_obj

  def create_review_obj
    review = Review.new
    review.order_item_id = self.id
    review.uuid = SecureRandom.uuid
    review.save
  end

end
