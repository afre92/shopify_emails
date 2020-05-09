# frozen_string_literal: true

class CustomerMailer < ApplicationMailer
  def send_email(email)
    @email = email
    mail(to: @email.to,
         subject: @email.subject,
         from: @email.from)
  end
end
