# frozen_string_literal: true

class Email < ApplicationRecord
  belongs_to :order
  belongs_to :shop
  belongs_to :template
  has_one :tracking_pixel

  validates_presence_of :order_id, :template_id, :shop_id

  after_create :add_tracking_pixel
  before_save :replace_quote_entities_with_escape_characters

  enum was_sent: { not_sent: 0, sent: 1, error: 2 }
  scope :sent, -> { where(was_sent: 'sent') } do
    def opened
      if count > 0
        opened = 0
        each do |email|
          opened += 1 if email.tracking_pixel.views > 0
        end
        return opened
      else
        0
      end
    end
  end

  def add_tracking_pixel
    tracking_pixel = TrackingPixel.create(template_id: template_id, shop_id: shop_id, email_id: id)
    body_index = html.index('</body>')
    self.html = html.insert(body_index, tracking_pixel.conversion_tag)
    save
  end

  def replace_quote_entities_with_escape_characters
    self.html = html.gsub('&quot;', '"').gsub('&ldquo;', '"').gsub('&rdquo;', '"').gsub('&lsquo;', '"').gsub('&rsquo;', '"').gsub('&lt;', '<').gsub('&gt;', '>').gsub('{{', '<%=').gsub('}}', '%>')
  end
end
