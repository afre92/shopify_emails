class CustomerMailer < ApplicationMailer
  default :from => 'your_store@email.com'

  def send_thank_you_email#(customer)
    # @shop = shop
    # @custumer = customer
    # mail( :to => 'afre92@gmail.com',
    # :subject => 'Thanks for Visiting our amazing store' )
    @shop = Shop.last
    @template = @shop.thank_you_template
    mail( :to => 'afre92@gmail.com',
    :subject => 'Please review the items you recieved' )
  end

  def send_please_review_email#(user)
    @shop = Shop.last
    @template = @shop.thank_you_template
    mail( :to => 'afre92@gmail.com',
    :subject => 'Please review the items you recieved' )
  end
end
