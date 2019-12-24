class ChangeColumnTypeTemplate < ActiveRecord::Migration[5.2]
  def change
    change_column :templates, :body, :jsonb, using: 'body::jsonb', default: '{}'
  end
end
