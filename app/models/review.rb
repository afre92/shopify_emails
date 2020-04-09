class Review < ApplicationRecord
  belongs_to :email
  enum review_status: { pending: 0, completed: 1}
end
