class AddUuidToEmails < ActiveRecord::Migration[5.2]
  def change
    add_column :emails, :uuid, :string
  end
end
