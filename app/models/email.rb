class Email < ApplicationRecord
  belongs_to :order
  belongs_to :shop 
  belongs_to :template
end
