class ReviewsController < AuthenticatedController
  before_action :find_store

  def index
    @reviews = @shop.reviews.where(review_status: 'completed').paginate(page: params[:page], per_page: 3)
  end

  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @view = 'reviews'
  end

end