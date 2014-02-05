class CreateAvatars < ActiveRecord::Migration
  def self.up
    create_table :avatars do |t|
      t.attachment :avatar
      t.references :avatarable, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :avatars
  end
end
