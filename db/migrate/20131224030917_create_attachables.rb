class CreateAttachables < ActiveRecord::Migration
  def change
    create_table :attachables do |t|
      t.attachment :image
      t.references :imageable, :polymorphic => true
      t.timestamps
    end
  end
end
