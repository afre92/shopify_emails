# frozen_string_literal: true

module UserPlans
  def get_plan(id)
    plans = {
      'free' => {
        name: 'Free',
        price: 0.00,
        test: true,
        capped_amount: 0.00,
        number_of_emails: 100,
        terms: '1000 emails for free'
      },
      'basic' => {
        name: 'Basic',
        price: 9.99,
        test: true,
        capped_amount: 9.99,
        number_of_emails: 7000,
        terms: '7000 emails for $9.99'
      },

      'pro' => {
        name: 'Pro',
        price: 12.99,
        test: true,
        capped_amount: 12.99,
        number_of_emails: 15_000,
        terms: '15000 emails for $12.99'
      }
    }
    plans[id]
  end
end
