class AddActorIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :actor_id, :string
  end
end
