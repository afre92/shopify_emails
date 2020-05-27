class ReviewsController < AuthenticatedController
  before_action :find_store
  before_action :set_daterange, only: :index

  def index
    @reviews = @shop.reviews.where(review_status: 'completed', submitted_on: @daterange).paginate(page: params[:page], per_page: 10)
  end

  def show
    @review = @shop.reviews.find(params['id'])
    @customer = JSON.parse(@review.order.customer)
  end

  def update
    review = @shop.reviews.find(params['id'])
    if review.update(exported: !review.exported)
      flash[:success] = "Review updated successfully."
    else
      flash[:danger] = "Ooops, something is wrong "
    end
    redirect_to reviews_path
  end


  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @view = 'reviews'
  end

end