class HmacAuthenticatedController < ApplicationController
  before_action :verify_hmac

  def verify_hmac
  end
  # should the review submition be authenticated ?
end