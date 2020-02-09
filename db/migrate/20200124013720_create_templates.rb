# frozen_string_literal: true

class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.string :from, default: ''
      t.integer :template_type, default: 0
      t.string :subject, default: ''
      t.string :reply_to, default: ''
      t.jsonb :body, default: '{}'
      t.integer :shop_id
      t.text :html, default: ''

      t.timestamps
    end
  end
end
