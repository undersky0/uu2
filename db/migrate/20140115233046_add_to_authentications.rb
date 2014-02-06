class AddToAuthentications < ActiveRecord::Migration
  def up
		add_column :authentications, :token_secret, :string
  end

  def down
  end
end
