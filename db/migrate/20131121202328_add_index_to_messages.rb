class AddIndexToMessages < ActiveRecord::Migration
  def change
  end
  add_index :messages, :user_id
  add_index :messages, :ancestry 
end
