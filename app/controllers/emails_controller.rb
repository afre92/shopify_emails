# frozen_string_literal: true

class EmailsController < ShopifyAuthenticatedController
  before_action :find_store
  before_action :set_daterange, only: :index

  def index
    @emails = @shop.emails.where(scheduled_time: @daterange).order('scheduled_time DESC').paginate(page: params[:page], per_page: 10)
  end

  def show
    @email     = @shop.emails.find(params['id'])
    email_html = Nokogiri::HTML(@email.html)
    email_html.search('img.tp').each(&:remove)
    @email.html = email_html.to_html
  end

  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @view = 'emails'
  end
end
