class ChangeLocationAgain < ActiveRecord::Migration
  def up
    rename_column :groups, :location, :location_name
  end

  def down
  end
end
