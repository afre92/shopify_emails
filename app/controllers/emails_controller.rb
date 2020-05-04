class EmailsController < AuthenticatedController
  before_action :find_store

  def index
    @emails = @shop.emails.order('scheduled_time DESC').paginate(page: params[:page], per_page: 10)
  end

  def show
    @email = @shop.emails.find(params['id'])
    order = @shop.orders.find(@email.order_id)
    @customer = order.customer_obj
  end

  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @view = 'emails'
  end

end