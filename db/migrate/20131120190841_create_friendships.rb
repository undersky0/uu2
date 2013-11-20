class CreateFriendships < ActiveRecord::Migration
  def up
    create_table "friendships", :force => true  do |t|
      t.string "actor_id"
      t.string "friendActor_id"
      t.string "status"
      t.datetime "created_at"
    end
  end
  
  def down
    drop_table "friendships"
  end
end
