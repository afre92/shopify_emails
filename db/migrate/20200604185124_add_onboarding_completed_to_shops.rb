class AddOnboardingCompletedToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :onboarding_completed, :boolean, default: false
  end
end
