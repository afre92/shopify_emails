# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  has_one :review, dependent: :destroy

  after_create :create_review_obj

  def create_review_obj
    review = self.build_review
    review.uuid = SecureRandom.uuid
    review.save
  end

end
