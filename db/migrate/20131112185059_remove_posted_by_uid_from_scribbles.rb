class RemovePostedByUidFromScribbles < ActiveRecord::Migration
 def change
   remove_column :scribbles, :posted_by_uid
 end
end
