class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.date :age
      t.string :website
      t.string :phoneNo
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
