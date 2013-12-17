class AddScribbledIdAndScribbledTypeToScribbles < ActiveRecord::Migration
  def change
    add_column :scribbles, :scribbled_id, :integer
    add_column :scribbles, :scribbled_type, :string
  end
end
