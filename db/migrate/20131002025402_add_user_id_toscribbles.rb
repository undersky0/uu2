class AddUserIdToscribbles < ActiveRecord::Migration
  def up
    add_column :scribbles, :user_id, :integer
  end

  def down
  end
end
