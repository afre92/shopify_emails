# frozen_string_literal: true

class Template < ApplicationRecord
  belongs_to :shop
  has_many :emails, dependent: :destroy

  validates_presence_of :shop_id

  enum template_type: { thank_you: 0, review: 1}

end
