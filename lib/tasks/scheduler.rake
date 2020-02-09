# frozen_string_literal: true

task send_emails: :environment do
  emails = Email.where(was_sent: 0, scheduled_time: (DateTime.now.utc - 15.minutes...DateTime.now.utc))
  emails.each do |email|
    if CustomerMailer.send_email(email).deliver
      email.update(was_sent: 1)
      # -1 tokens
    else
      email.update(was_sent: 2)
      # TODO: notify me about error
    end
  end
end
