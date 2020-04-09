class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.belongs_to :email
      t.integer :rating, default: 0
      t.string :title, default: ''
      t.text :description, default: ''
      t.integer :review_status, default: 0

      t.timestamps
    end
  end
end
