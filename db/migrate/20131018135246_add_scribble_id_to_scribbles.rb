class AddScribbleIdToScribbles < ActiveRecord::Migration
  def change
    add_column :scribbles, :scribble_id, :integer
  end
end
