class AddActorIdToScribbles < ActiveRecord::Migration
  def change
    add_column :scribbles, :actor_id, :string
		remove_column :scribbles, :user_id, :string
  end
end
