class AddActorIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :actor_id, :string
  end
end
