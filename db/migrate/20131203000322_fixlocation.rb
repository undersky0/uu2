class Fixlocation < ActiveRecord::Migration
  def up
    add_column :locations, :user_id, :integer
  end

  def down
  end
end
