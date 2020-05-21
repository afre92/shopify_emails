class EmailsController < AuthenticatedController
  before_action :find_store

  def index
    @daterange = params[:daterange] ? format_daterange(params[:daterange]) : (DateTime.now.beginning_of_month...DateTime.now)
    @emails = @shop.emails.where(scheduled_time: @daterange).order('scheduled_time DESC').paginate(page: params[:page], per_page: 10)
  end

  # this is suppouse to format for js plugin
  def format_daterange(daterange)
    from, to = daterange.split('...')
    (from.to_datetime.beginning_of_day...to.to_datetime.end_of_day)
  end

  def show
    email = @shop.emails.find(params['id'])
    @email_html = Nokogiri::HTML(email.html)
    @email_html.search('img.tp').each(&:remove)
    order = @shop.orders.find(email.order_id)
    @customer = order.customer_obj
  end

  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @view = 'emails'
  end

end