class CreateReviewTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :review_templates do |t|
      t.string :from, default: ''
      t.string :subject, default: ''
      t.string :reply_to, default: ''
      t.jsonb :body
      t.integer :shop_id
      t.text :html, default: ''

      t.timestamps
    end
  end
end
