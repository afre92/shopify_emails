# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :order_item, dependent: :destroy
  enum review_status: { pending: 0, completed: 1, completed: 2 }
  has_one :order, through: :order_item
  # has_many_attached :images

  def rating_stars(color = '#ffd700')
    total = []
    rating.times do |_t|
      total << '★'
    end
    "<span style='color:#{color};'>#{total.join('')}</span>".html_safe
  end
end
