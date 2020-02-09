# frozen_string_literal: true

class CustomerMailer < ApplicationMailer
  def send_email(email)
    @email = email
    @shop = Shop.find(@email.shop_id)
    @customer = JSON.parse(@shop.orders.find(@email.order_id).customer, object_class: OpenStruct)
    @template = @shop.templates.find(@email.template_id)

    mail(to: @customer.email,
         subject: @template.subject,
         from: @template.from)
  end
end
