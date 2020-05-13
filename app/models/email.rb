# frozen_string_literal: true

class Email < ApplicationRecord
  belongs_to :order
  belongs_to :shop
  has_one :tracking_pixel

  # before_create :check_limit_for_order
  after_create :add_tracking_pixel  

  enum was_sent: { not_sent: 0, sent: 1, error: 2 }
  enum email_type: { thank_you: 0, review: 1}

  attr_reader :shop, :order, :email_type, :template

  def initialize(params = {})
    super
    @shop = params.fetch(:shop)
    @order = params.fetch(:order)
    @email_type = params.fetch(:email_type)
    @template = @shop.templates.find_by(template_type: @email_type)
  end


  # change this name to better describe process
  def add_delivery_data

    self.from = template.from
    self.subject = template.subject
    self.to = order.customer_obj.email
    self.scheduled_time = order.shopify_created_at + (email_type == 'review' ? shop.review_interval.days : shop.thank_you_interval.minutes)
    self.html = populate_html
  end

  def parse_html(html = template.html)
    product_name = order.order_items.first.title
    customer = order.customer_obj
    parsed_html = ERB.new(html)
    return parsed_html.result(binding)
  end

  def populate_html
    parsed_html = ''
    
    if email_type == 'thank_you'
      parsed_html = parse_html
    else

      parsed_template = parse_html
      parsed_review_form = parse_html(File.read(Rails.root + "app/views/templates/_review_form.html.erb"))
  
      # inject to html with Nokogiri
      parsed_template = Nokogiri::HTML(parsed_template)
      div = parsed_template.css('div.email-row-container').last
      div.add_next_sibling(parsed_review_form)

      parsed_html = parsed_template.to_html
    end

    return parsed_html
  end







  def template_type
    template = Template.find(self.template_id)
    return template.template_type
  end


  def check_limit_for_order
    raise 'Email limit for order reached' if Order.find(order_id).emails.count >= 2
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



