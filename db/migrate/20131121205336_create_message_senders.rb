class CreateMessageSenders < ActiveRecord::Migration
  def change
    create_table :message_senders do |t|

      t.timestamps
    end
  end
end
