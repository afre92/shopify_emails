class AnalyticsController < ApplicationController

  def convert
    tracking_pixel = TrackingPixel.find_by(token: params[:token])
		if tracking_pixel.present?
			tracking_pixel.increment_views
		end
		head 204, content_type: "text/html"
  end

end
