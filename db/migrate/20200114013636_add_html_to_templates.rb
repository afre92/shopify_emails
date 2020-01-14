class AddHtmlToTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :templates, :html, :text
  end
end
