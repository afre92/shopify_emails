class AddExportedToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :exported, :boolean, default: false
  end
end
