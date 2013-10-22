class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :sender_id
      t.string :recipient_id
      t.text :body
      t.datetime :read_at

      t.timestamps
    end
  end
end
