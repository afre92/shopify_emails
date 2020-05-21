# frozen_string_literal: true

class ApplicationController < ActionController::Base
  after_action :allow_shopify_iframe

  def set_daterange
    @daterange = params[:daterange] ? format_daterange(params[:daterange]) : (DateTime.now.beginning_of_month...DateTime.now)
  end

  def format_daterange(daterange)
    if daterange.include?('...')
      from, to = daterange.split('...')
      return (from.to_datetime.beginning_of_day...to.to_datetime.end_of_day)
    else
      from, to = daterange.split('-')
      return (DateTime.strptime(from.remove(' '), '%m/%d/%Y')...DateTime.strptime(to.remove(' '), '%m/%d/%Y'))
    end
  end

  private

  def allow_shopify_iframe
    response.headers['X-Frame-Options'] = 'ALLOWALL'
  end
  
end
