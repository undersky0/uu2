class AddProfileFirstnameToMessages < ActiveRecord::Migration
  def change
		add_column :messages, :profile_firstname, :string
  end
end
