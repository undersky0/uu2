class Fixmaptest3s < ActiveRecord::Migration
  def up
		rename_column :maptest3s, :lonitude, :longitude
  end

  def down
  end
end
