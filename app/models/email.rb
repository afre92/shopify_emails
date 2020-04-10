# frozen_string_literal: true

class Email < ApplicationRecord
  belongs_to :order
  belongs_to :shop
  belongs_to :template
  has_one :tracking_pixel
  has_one :review, dependent: :destroy

  validates_presence_of :order_id, :template_id, :shop_id

  after_create :add_tracking_pixel
  after_create :create_review_obj
  before_save :attach_uuid_and_review_form, on: :create
  
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


  def create_review_obj
    return unless Template.find(self.template_id).template_type == 'review'
    review = Review.new
    review.email_id = self.id
    review.save
  end

  def attach_uuid_and_review_form
    return unless Template.find(self.template_id).template_type == 'review'
    loop do
      random_uuid = SecureRandom.uuid
      return (self.uuid = random_uuid) unless Email.exists?(uuid: random_uuid)
    end
    # byebug
    # shop = Shop.find(shop_id)
    # template = shop.templates.find_by(template_type: 'review')
    # template_html = template.html
    # body_index = template_html.index('</body>') 
   
    # #attach review form
    # ac = ActionController::Base.new()
    # review_form = ac.render_to_string :template => 'templates/_review_form.html.erb'
    # self.template_id = template.id
    # self.html = template_html.insert(body_index, review_form)
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
