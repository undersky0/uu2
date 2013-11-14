class AddUserIdToScribbles < ActiveRecord::Migration
  def change
    add_column :scribbles, :user_id, :integer
  end
end
