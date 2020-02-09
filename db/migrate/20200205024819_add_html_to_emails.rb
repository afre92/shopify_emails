# frozen_string_literal: true

class AddHtmlToEmails < ActiveRecord::Migration[5.2]
  def change
    add_column :emails, :html, :text
  end
end
