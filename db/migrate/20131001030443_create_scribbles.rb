class CreateScribbles < ActiveRecord::Migration
  def self.up
    create_table :scribbles do |t|
      t.string :post
      t.string :posted_by
      t.integer :posted_by_uid
      t.integer :promotes
      t.integer :demotes
      t.timestamps
    end
  end

  def self.down
    drop_table :scribbles
  end
end
