class EmailsController < AuthenticatedController
  before_action :find_store

  def index
    @emails = @shop.emails.order('scheduled_time DESC').paginate(page: params[:page], per_page: 10)
  end

  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @view = 'emails'
  end

end