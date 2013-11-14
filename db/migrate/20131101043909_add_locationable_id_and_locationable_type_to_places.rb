class AddLocationableIdAndLocationableTypeToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :locationable_id, :integer
    add_column :places, :locationable_type, :string
  end
end
