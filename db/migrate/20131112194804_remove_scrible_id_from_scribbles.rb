class RemoveScribleIdFromScribbles < ActiveRecord::Migration
  def up
    remove_column :scribbles, :scribble_id
  end

  def down
    add_column :scribbles, :scribble_id, :integer
  end
end
