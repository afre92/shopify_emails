# frozen_string_literal: true

class Email < ApplicationRecord
  belongs_to :order
  belongs_to :shop
  has_one :tracking_pixel, dependent: :destroy

  before_create :check_limit_for_order
  after_create :add_tracking_pixel

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
    self.html = paca_test
    # the plan is to render the template object on the email defaults html
      #get email data and bind it with template data
  end


  def paca_test
    # get default template and order info to craft email
    return File.read(Rails.root + 'app/views/reviews/_review_form.html.erb')
  end

  # def parse_html(html = template.html)
  #   product_name = order.order_items.order('id ASC').first.title if @email_type == 'review'
  #   customer = order.customer_obj
  #   # get template 
  #   parsed_html = ERB.new(html)
  #   # binding does parse variables into real values
  #   parsed_html.result(binding)
  # end

  # # I might be able to remove this method
  # def populate_html
  #   parsed_html = ''
  #   if @email_type == 'thank_you' # there is no form injected needed
  #     parsed_html = parse_html # this gives me the parsed and rendered form
  #   else
  #     parsed_template = parse_html # this gives me the parsed and rendered form
  #     parsed_review_form = parse_html(File.read(Rails.root + 'app/views/reviews/_review_form.html.erb'))

  #     # inject review partial into template with nokogiri
  #     parsed_template = Nokogiri::HTML(parsed_template)

  #     #replacing the default for the custom
  #     div = parsed_template.css('div.email-row-container').last
  #     div.add_next_sibling(parsed_review_form)

  #     parsed_html = parsed_template.to_html
  #   end

  #   parsed_html
  # end

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
