class Fixusers < ActiveRecord::Migration
  def up
		change_table :users do |t|
		    t.change :actor_id, :string, :null => false, :unique => true
		  end
  end

  def down
  end
end
