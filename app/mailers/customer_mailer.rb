class CustomerMailer < ApplicationMailer
  default :from => 'your_store@email.com'

  def send_thank_you_email(customer)
    # @custumer = customer
    mail( :to => 'afre92@gmail.com',
    :subject => 'Thanks for Visiting our amazing store' )
  end

  def send_please_review_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Please review the items you recieved' )
  end
end
