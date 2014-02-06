class Fixavatar < ActiveRecord::Migration
  def up
		rename_column :avatars, :avatar_file_name, :photo_file_name
		rename_column :avatars, :avatar_content_type, :photo_content_type
		rename_column :avatars, :avatar_file_size, :photo_file_size
		rename_column :avatars, :avatar_updated_at, :photo_updated_at
  end

  def down
  end
end
