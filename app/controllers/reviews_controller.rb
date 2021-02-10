# frozen_string_literal: true

class ReviewsController < ShopifyAuthenticatedController
  before_action :find_store
  before_action :set_daterange, only: :index

  def index
    @exported = params[:exported] || false
    @reviews = @shop.reviews.where(review_status: 'completed').paginate(page: params[:page], per_page: 10)
  end

  def show
    @review = @shop.reviews.find(params['id'])
    @customer = JSON.parse(@review.order.customer)
  end

  def update
    review = @shop.reviews.find(params['id'])
    if review.update(exported: !review.exported)
      flash[:success] = 'Review updated'
    else
      flash[:danger] = 'Something is wrong'
    end
    redirect_to reviews_path
  end

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

  private

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


    def review_params
      params.require(:review).permit( :rating, :title, :description, :review_status, images: [])
    end
    
    def find_store
      @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
      @view = 'reviews'
    end
end
