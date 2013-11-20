class Fixmessages < ActiveRecord::Migration
  def up
    add_column :messages, :parent_id, :string
    add_column :messages, :sender_deleted_at, :datetime
    add_column :messages, :sender_read_at, :datetime
    add_column :messages, :recipient_deleted_at, :datetime
    add_column :messages, :recipient_read_at, :datetime
    add_column :messages, :container, :string, :default => "draft"
  end

  def down
  end
end
