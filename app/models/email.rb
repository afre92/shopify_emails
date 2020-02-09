class Email < ApplicationRecord
  belongs_to :order
  belongs_to :shop 
  belongs_to :template
  has_one :tracking_pixel

  after_create :add_tracking_pixel

  enum was_sent: { not_sent: 0, sent: 1, error: 2}

  def add_tracking_pixel
    tracking_pixel = TrackingPixel.create(template_id: self.template_id, shop_id: self.shop_id, email_id: self.id)
    body_index = self.html.index('</body>')
    self.html = self.html.insert(body_index, tracking_pixel.conversion_tag)
    self.save
  end

end
