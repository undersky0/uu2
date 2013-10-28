class AddActorIdAndLocationIdToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :actor_id, :string
    add_column :places, :location_id, :integer
  end
end
