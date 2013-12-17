class CreateLocalfeeds < ActiveRecord::Migration
  def self.up
    create_table :localfeeds do |t|
      t.string :city
      t.integer :scribble_id
      t.integer :location_id
      t.timestamps
    end
  end

  def self.down
    drop_table :localfeeds
  end
end
