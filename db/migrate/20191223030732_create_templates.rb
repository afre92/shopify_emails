class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.string :from
      t.string :subject
      t.string :reply_to
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
