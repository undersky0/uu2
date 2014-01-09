class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :album_id
      t.string :image
      t.string :description
      t.string :name
      t.timestamps
    end
  end
end
