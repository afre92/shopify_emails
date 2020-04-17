# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :shop
  has_many :order_items, dependent: :destroy
  has_many :reviews, through: :order_items
  has_many :emails, dependent: :destroy

  validates_presence_of :shop_id
end
