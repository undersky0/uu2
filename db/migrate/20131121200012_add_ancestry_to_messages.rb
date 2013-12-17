class AddAncestryToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :ancestry, :string
		rename_column :messages, :recepient_id, :recipient_ids
		remove_column :messages, :sender_id
		rename_column :messages, :sender_deleted_at, :deleted_at
		rename_column :messages, :recipient_read_at, :received_at
		rename_column :messages, :recipient_deleted_at, :trashed_at
		remove_column :messages, :seder_read_at
		remove_column :messages, :parent_id
		remove_column :messages, :container
		add_column :messages, :user_id, :integer
		add_column :messages, :editable, :boolean, default: true
		
		 end
    
  
  def self.down
		rename_column :messages, :trashed_at, :recipient_deleted_at
		rename_column :messages, :received_at, :recipient_read_at
		rename_column :messages, :deleted_at, :sender_deleted_at
		rename_column :messages, :recipient_ids, :recipient_id
    
  end
    
end
  