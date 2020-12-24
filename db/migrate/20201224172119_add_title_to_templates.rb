class AddTitleToTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :templates, :title, :string, default: ''
  end
end
