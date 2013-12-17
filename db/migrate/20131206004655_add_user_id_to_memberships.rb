class AddUserIdToMemberships < ActiveRecord::Migration
  def change
		add_column :memberships, :user_id, :integer
		remove_column :memberships, :role
		remove_column :memberships, :actor_id
  end
end
