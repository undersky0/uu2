class RemoveActorIdFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :actor_id
  end

  def down
    add_column :places, :actor_id, :string
  end
end
