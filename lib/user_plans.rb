module UserPlans
  def get_plan(id)
    plans = {
      1 => {
        name: "Basic plan",
        price: 9.99,
        test: true,
        capped_amount: 9.99,
        terms: "7000 email for $9.99"
      },

      2 => {
        name: "Pro plan",
        price: 12.99,
        test: true,
        capped_amount: 12.99,
        terms: "15000 email for $12.99"
      }
    }
    return plans[id.to_i]
  end
end