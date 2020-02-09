# frozen_string_literal: true

class AnalyticsController < ApplicationController
  def convert
    tracking_pixel = TrackingPixel.find_by(token: params[:token])
    tracking_pixel.increment_views if tracking_pixel.present?
    head 204, content_type: 'text/html'
  end
end
