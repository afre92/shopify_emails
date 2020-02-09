# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :shop
  has_many :order_items
  has_many :emails
end
