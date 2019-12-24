class RenameUserIdinTemlate < ActiveRecord::Migration[5.2]
  def change
    rename_column :templates, :user_id, :shop_id
  end
end
