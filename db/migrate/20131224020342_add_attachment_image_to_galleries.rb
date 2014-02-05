class AddAttachmentImageToGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      t.attachment :image
      t.references :imageable, :polymorphic => true
    end
  end

  def self.down
    drop_table :gallleries
  end
end
