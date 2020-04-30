# frozen_string_literal: true

task send_emails: :environment do

  emails = Email.where(was_sent: 0, scheduled_time: (DateTime.now.utc - 2.days...DateTime.now.utc)).group_by(&:shop_id)

  emails.keys.each do |key|
    begin
      shop = Shop.find(key)
      emails[key].each do |email|
        next if shop.tokens == 0.0
        if CustomerMailer.send_email(email).deliver
          email.update(was_sent: 1)
          shop.update(tokens: (shop.tokens - 1.0))
        else
          email.update(was_sent: 2)
          # TODO: notify me about error
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      puts e
    end

  end

end
