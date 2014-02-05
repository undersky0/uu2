class FixAlbums < ActiveRecord::Migration
  def up
		add_column :albums, :cover, :integer
		add_column :albums, :token, :string
  end

  def down
  end
end
