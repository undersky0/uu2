class AddActorIdToMemberships < ActiveRecord::Migration
  def change
		remove_column :memberships, :user_id
		remove_column :memberships, :role
    add_column :memberships, :actor_id, :string
  end
end
