# frozen_string_literal: true

class Email < ApplicationRecord
  belongs_to :order
  belongs_to :shop
  belongs_to :template
  has_one :tracking_pixel

  validates_presence_of :order_id, :template_id, :shop_id

  after_create :add_tracking_pixel
  # before_save :replace_quote_entities_with_escape_characters
  
  
  enum was_sent: { not_sent: 0, sent: 1, error: 2 }
  enum email_type: { thank_you: 0, review: 1}


  def self.create_thank_you_type(shop, order)
    template = shop.templates.find_by(template_type: 'thank_you')
    email = Email.new
    email.email_type = 'thank_you'
    email.shop_id = shop.id
    email.order_id = order.id
    email.scheduled_time = order.shopify_created_at + shop.thank_you_interval.minutes
    email.template_id = template.id
    email.from = template.from
    email.subject = template.subject

    # replace this
    email.to = order.customer_obj.email
    email.template_id
    email.html = parse_html_template(shop, order)
    email.save
  end


  def self.parse_html_template(shop, order)
    customer = order.customer_obj
    # and this
    template_html = shop.templates.find_by(template_type: 'thank_you').replace_quote_entities
    parsed_html = ERB.new(template_html)
    return parsed_html.result(binding)
  end

  def template_type
    template = Template.find(self.template_id)
    return template.template_type
  end
  
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
    body_index = self.html.index('</body>')
    self.html = self.html.insert(body_index, tracking_pixel.conversion_tag)
    save
  end

end
