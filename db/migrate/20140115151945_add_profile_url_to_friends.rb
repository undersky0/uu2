class AddProfileUrlToFriends < ActiveRecord::Migration
  def change
    add_column :mappedfriends, :profile_url, :string
  end
end
