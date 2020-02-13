# frozen_string_literal: true

class Template < ApplicationRecord
  belongs_to :shop
  has_many :emails

  validates_presence_of :shop_id

  def test_insert
    html.insert(5819, '<%= shop.shopify_domain %>')
  end
end
