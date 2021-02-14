class External::ReviewsController < ApplicationController
  before_action :validate_uuid

  def update
    if @review.update(review_params)

      if @review.review_status == 'completed'
        if @shop.price_rule.active
          discount_code = @shop.temp_session(:create_discount_code)
          render json: "Thank you for your review. Your discount code is: #{discount_code.code}"
        else
          render json: 'Thank you for your review.'
        end

      else
        redirect_to action: 'images_upload'
      end

      
    else
      # render error page
    end
  end

  def images_upload
  end

  def validate_uuid
    @review = Review.find_by(uuid: params[:uuid])
    if @review.nil?
      return redirect_to not_found_path
    elsif @review.review_status == "completed"
      render json: 'Your review has already been submitted, thank you!'
      # redirect_to thank you for submitting you review page
    end
    @shop = Shop.find(@review.order.shop_id)
    # find email and find the status of review
  end

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