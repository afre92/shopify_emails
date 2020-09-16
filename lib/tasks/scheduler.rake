# frozen_string_literal: true

task send_emails: :environment do
  emails = Email.where(was_sent: 'not_sent', scheduled_time: (DateTime.now.utc - 2.days...DateTime.now.utc)).group_by(&:shop_id)
  emails.keys.each do |key|
    begin
      shop = Shop.find(key)
      emails[key].each do |email|
        next if shop.tokens == 0.0

        if CustomerMailer.send_email(email).deliver
          email.update_attribute(:was_sent, 'sent')
          shop.update_attribute(:tokens, (shop.tokens - 1.0))
        else
          email.update_attribute(:was_sent, 'error')
          # TODO: notify me about error
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      puts e
    end
  end
end
