# frozen_string_literal: true

class Template < ApplicationRecord
  belongs_to :shop
  enum template_type: { thank_you: 0, review: 1 }
end
