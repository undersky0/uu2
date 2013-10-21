class AddActorIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :actor_id, :string
    add_column :users, :profile_id, :string
  end
end
