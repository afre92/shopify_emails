class Review < ApplicationRecord
  belongs_to :order_item, dependent: :destroy
  enum review_status: { pending: 0, completed: 1}
  has_one :order, through: :order_item

  def rating_stars
    total=[] 
    rating.times do |t|
      total << '★' 
    end 
    return "<span style='color: #ffd700;'>#{total.join('')}</span>".html_safe
  end

end
