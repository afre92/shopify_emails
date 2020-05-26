class AddIndividualStatusForEmailTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :thank_you_status, :integer, default: 0
    add_column :shops, :review_status, :integer, default: 0
  end
end
