class Fixattachables < ActiveRecord::Migration
  def up
		remove_column :attachables, :imageable_id
		remove_column :attachables, :imageable_type
		add_column :attachables, :gallery_id, :integer
  end

  def down
  end
end
