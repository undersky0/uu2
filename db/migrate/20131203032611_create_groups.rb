class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.integer :location_id
      t.string :type
      t.string :privacy
      t.string :about
      t.integer :membership_id
      t.integer :event_id
      t.string :headline
      t.string :location
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
