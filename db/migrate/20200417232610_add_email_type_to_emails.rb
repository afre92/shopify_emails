class AddEmailTypeToEmails < ActiveRecord::Migration[5.2]
  def change
    add_column :emails, :email_type, :integer
  end
end
