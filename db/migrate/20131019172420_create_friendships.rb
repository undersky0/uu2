class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.string :actor_id
      t.string :friendActor_id
      t.string :status

      t.timestamps
    end
  end
end
