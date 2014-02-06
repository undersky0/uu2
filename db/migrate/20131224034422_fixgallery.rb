class Fixgallery < ActiveRecord::Migration
  def up

		remove_column :galleries, :imageable_id

		
  end

  def down
  end
end
