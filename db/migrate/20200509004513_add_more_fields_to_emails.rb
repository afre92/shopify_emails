class AddMoreFieldsToEmails < ActiveRecord::Migration[5.2]
  def change
    add_column :emails, :from, :string, default: ''
    add_column :emails, :to, :string, default: ''
    add_column :emails, :subject, :string, default: ''
    add_column :emails, :uuid, :string
    add_column :emails, :email_type, :integer
  end
end
