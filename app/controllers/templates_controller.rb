# frozen_string_literal: true

class TemplatesController < AuthenticatedController
  before_action :find_store
  before_action :find_template, only: :update

  def index
    set_token
    order = @shop.sample_order
    @thank_you_template = @shop.templates.find_by(template_type: 'thank_you')
    @review_template = @shop.templates.find_by(template_type: 'review')
  end

  def edit
    @template = @shop.templates.first
  end

  def update
    if @template.update(template_params)
      flash[:success] = 'Template updated.'
    else
      flash[:danger] = 'Ooops, something is wrong '
    end
    redirect_to templates_path
  end

  def set_token
    shop_token = @shop.web_token + Date.current.month.to_s
    @token = Digest::SHA2.hexdigest shop_token
  end

  def preview
    @order = @shop.sample_order
    @template = @shop.templates.find_by(template_type: params[:template_id])
  end

  private

  def template_params
    params.require(:template).permit(:from, :subject, :reply_to, :body, :html, :title)
  end

  def find_store
    @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
    @view = 'templates'
  end

  def find_template
    @template = @shop.templates.find(params[:id])
  end
end
