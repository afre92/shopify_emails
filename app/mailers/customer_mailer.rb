class CustomerMailer < ApplicationMailer
  default :from => 'your_store@email.com'

  def send_thank_you_email#(customer)
    @shop = Shop.last
    @template = @shop.templates.first
    mail( :to => 'afre92@gmail.com',
    :subject => 'Thank for your purchase' )
  end

  def send_please_review_email#(user)
    @shop = Shop.last
    @template = @shop.templates.first
    mail( :to => 'afre92@gmail.com',
    :subject => 'Please review the items you recieved' )
  end
end
