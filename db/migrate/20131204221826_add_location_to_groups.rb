class AddLocationToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :Location, :string
  end
end
