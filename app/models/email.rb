# frozen_string_literal: true

class Email < ApplicationRecord
  belongs_to :order
  belongs_to :shop
  has_one :tracking_pixel, dependent: :destroy

  before_create :check_limit_for_order
  # after_create :add_tracking_pixel

  enum was_sent: { not_sent: 0, sent: 1, error: 2 }
  enum email_type: { thank_you: 0, review: 1 }

  attr_reader :shop, :order, :template

  scope :sent, -> { where(was_sent: 'sent') } do
    def opened
      if count > 0
        opened = 0
        each do |email|
          opened += 1 if email.tracking_pixel.views > 0
        end
        opened
      else
        0
      end
    end
  end

  def initialize(params = {})
    super
    @order = params.fetch(:order)
    @shop = Shop.find(@order.shop_id)
    @email_type = params.fetch(:email_type)
    @template = @shop.templates.find_by(template_type: @email_type)
    add_delivery_data
  end

  def add_delivery_data
    self.from = template.from
    self.subject = template.subject
    self.to = order.customer_obj.email
    self.shop_id = order.shop_id
    self.scheduled_time = order.shopify_created_at + (@email_type == 'review' ?
       shop.review_interval.days :
        shop.thank_you_interval.minutes)
    self.html = generate_email_html
    # the plan is to render the template object on the email defaults html
      #get email data and bind it with template data
  end


  def generate_email_html
    # get default template and order info to craft email
    html      = nil
    shop      = @shop
    order     = @order
    template  = @template

    if @email_type == 'review'
      html = File.read(Rails.root + 'app/views/reviews/_review_form.html.erb')
    else
      html = File.read(Rails.root + 'app/views/reviews/_thank_you_form.html.erb')
    end
    parsed_html = ERB.new(html)
    return parsed_html.result(binding)
  end

  def template_type
    template = Template.find(template_id)
    template.template_type
  end

  def check_limit_for_order
    raise 'Email limit for order reached' if Order.find(order_id).emails.count >= 2
  end

  def add_tracking_pixel
    tracking_pixel = TrackingPixel.create(template_id: template_id, shop_id: shop_id, email_id: id)
    body_index = html.index('</body>')
    self.html = html.insert(body_index, tracking_pixel.conversion_tag)
    save
  end
end
