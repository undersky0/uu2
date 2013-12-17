class AddLocalfeedIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :localfeed_id, :integer
  end
end
