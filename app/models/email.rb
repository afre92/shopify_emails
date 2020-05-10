# frozen_string_literal: true

class Email < ApplicationRecord
  belongs_to :order
  belongs_to :shop
  belongs_to :template
  has_one :tracking_pixel

  validates_presence_of :order_id, :shop_id
  after_create :add_tracking_pixel  

  enum was_sent: { not_sent: 0, sent: 1, error: 2 }
  enum email_type: { thank_you: 0, review: 1}


  def self.create_thank_you_type(shop, order)
    template = shop.templates.find_by(template_type: 'thank_you')
    email = Email.new
    email.email_type = 'thank_you'
    email.shop_id = shop.id
    email.order_id = order.id
    email.scheduled_time = order.shopify_created_at + shop.thank_you_interval.minutes
    # template id might not be necessary
    email.template_id = template.id
    email.from = template.from
    email.subject = template.subject
    email.to = order.customer_obj.email
    email.html = parse_html_template(shop, order, template.html)
    email.save
  end


  def self.create_review_type(shop, order)
    ac = ActionController::Base.new()
    review_email = Email.new
    review_email.scheduled_time = order.shopify_created_at + shop.review_interval.days
    review_email.shop_id = shop.id
    review_email.email_type = 'review'
    review_email.order_id = order.id
    # review_email.uuid = SecureRandom.uuid
    review_template = shop.templates.find_by(template_type: 'review')

    # at tem
    template_html = Nokogiri::HTML(review_template.html)
    #grab all the order and all the items for it
    byebug
    review_form = File.open('templates/review_form.html.erb') { |f| Nokogiri::XML(f) }
    # review_form = Nokogiri::XML(File.open('templates/review_form.html.erb'))
    # not render but just paste,render later
    # review_form = ac.view_context.render partial: 'templates/review_form.html.erb', locals: {email: review_email, shop: shop, order: new_order}
    div = template_html.css('div.email-row-container').last
    div.add_next_sibling(review_form)
    
    
    review_email.html = template_html.to_html
    review_email.template_id = review_template.id
    review_email.save
  end

  def self.parse_html_template(shop, order, html)
    customer = order.customer_obj
    parsed_html = ERB.new(html)
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
