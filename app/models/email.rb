class Email < ApplicationRecord
  belongs_to :order
  belongs_to :shop 
  belongs_to :template
  has_one :tracking_pixel

  # before create
  # create tracking pixel
end
