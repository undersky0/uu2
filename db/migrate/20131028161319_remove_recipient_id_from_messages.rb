class RemoveRecipientIdFromMessages < ActiveRecord::Migration
  def up
    remove_column :messages, :recipient_id
    add_column :messages, :recepient_id, :string
  end

  def down
    add_column :messages, :recipient_id, :string
  end
end
