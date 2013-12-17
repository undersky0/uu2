class RolesUsers < ActiveRecord::Migration
		create_table :roles_users, :id => false, :force => true do |t|
		    t.references :users
		    t.references :role
		    t.timestamps
		  end
end