class Fixprofile < ActiveRecord::Migration
  def up
		change_table :profiles do |t|
		    t.change :profile_id, :string, :null => false, :unique => true
		  end
  end

  def down
  end
end
