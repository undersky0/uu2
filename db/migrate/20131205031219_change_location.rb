class ChangeLocation < ActiveRecord::Migration
  def up
		rename_column :groups, :Location, :location
  end

  def down
  end
end
