# frozen_string_literal: true

class TrackingPixel < ApplicationRecord
  belongs_to :email

  before_create :create_unique_token

  validates_presence_of :email_id

  def increment_views
    update_attribute(:views, views + 1)
  end

  def conversion_tag
    url = "#{ENV['APP_URL']}/convert/#{token}"
    "<img src='#{url}' width='0' height='0'>"
  end

  def create_unique_token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      return (self.token = random_token) unless TrackingPixel.exists?(token: random_token)
    end
  end
end
