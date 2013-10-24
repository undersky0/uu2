class AddProfileIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :profile_id, :string
  end
end
