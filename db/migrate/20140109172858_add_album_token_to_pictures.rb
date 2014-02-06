class AddAlbumTokenToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :album_token, :string
  end
end
