class CustomerMailer < ApplicationMailer
  # default :from => 'your_store@email.com'

  #both email will use this method, maybe change name  
  def send_thank_you_email(email)
    @shop = Shop.find(email.shop_id)
    @email = email
    @customer = JSON.parse(@shop.orders.find(@email.order_id).customer)
    @template = @shop.templates.find(@email.template_id)

    mail( to: @customer["email"],
    subject: @template.subject,
    from: @template.from)
  end

  # def send_please_review_email#(user)
  #   @shop = Shop.last
  #   @template = @shop.templates.first
  #   mail( :to => 'afre92@gmail.com',
  #   :subject => 'Please review the items you recieved' )
  # end
end
