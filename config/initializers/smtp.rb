# frozen_string_literal: true

ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 587,
  domain: ENV['SENDGRID_DOMAIN'],
  user_name: 'apikey',
  password: ENV['SENDGRID_PASSWORD'],
  authentication: :plain,
  enable_starttls_auto: true
}
