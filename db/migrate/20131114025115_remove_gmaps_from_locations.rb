class RemoveGmapsFromLocations < ActiveRecord::Migration
  def up
    remove_column :locations, :gmaps
  end

  def down
  end
end
