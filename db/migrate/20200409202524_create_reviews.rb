class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.belongs_to :email
      t.integer :rating
      t.string :title
      t.text :description
      t.integer :review_status

      t.timestamps
    end
  end
end
