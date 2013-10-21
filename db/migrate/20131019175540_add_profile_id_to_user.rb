class AddProfileIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_id, :string
    add_index "users", ["actor_id"], :name => "index_users_on_actor_id", :unique => true
    add_index "users", ["profile_id"], :name => "index_users_on_profile_id", :unique => true
  end
end
