require 'openssl'
require 'rack/utils'

class ProxyController < ActionController::Base
  before_action :verify_signature

  def reviews
    byebug
  end



  private

    def verify_signature
      query_string = request.query_string
      query_hash = Rack::Utils.parse_query(query_string)
      signature = query_hash.delete("signature")
      sorted_params = query_hash.collect{ |k, v| "#{k}=#{Array(v).join(',')}" }.sort.join
      calculated_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), ENV['SHOPIFY_API_SECRET'], sorted_params)
      raise 'Invalid signature' unless ActiveSupport::SecurityUtils.secure_compare(signature, calculated_signature)
    end
end