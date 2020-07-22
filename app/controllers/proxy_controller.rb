require 'openssl'
require 'rack/utils'

class ProxyController < ActionController::Base
  before_action :verify_signature

  def reviews
    # find id of the product
     # its going to be an id on a div
    # get all reviews for product
    @reviews = @shop.reviews.where(shopify_product_id: params[:id]).paginate(page: params[:page], per_page: 10)
    # @customer
    render :partial => 'reviews' , locals: {reviews: @reviews}
  end

  private

    def verify_signature
      query_string = request.query_string
      query_hash = Rack::Utils.parse_query(query_string)
      signature = query_hash.delete("signature")
      sorted_params = query_hash.collect{ |k, v| "#{k}=#{Array(v).join(',')}" }.sort.join
      calculated_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), ENV['SHOPIFY_API_SECRET'], sorted_params)
      raise 'Invalid signature' unless ActiveSupport::SecurityUtils.secure_compare(signature, calculated_signature)
      @shop = Shop.find_by(shopify_domain: query_hash['shop'])
    end
end