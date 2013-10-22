class Message < ActiveRecord::Base
  attr_accessible :body, :read_at, :recipient_id, :sender_id
  
  belongs_to :sender,
  :class_name => 'User',
  :primary_key => 'actor_id',
  :foreign_key => 'sender_id'
  
  belongs_to :recepient,
  :class_name => 'User',
  :primary_key => 'actor_id',
  :foreign_key => 'recipient_id'
  
  def self.readinmessage(id, reader)
    message = find(id, :conditions => ["sender_id = ? OR recipient_id = ?", reader, reader])
    if message.read_at.nil? && (message.recepient.actor_id == reader)
      message.read_at = Time.now
      message.save!
    end
  end
  def read?
      self.read_at.nil? ?false : true
  end
  
end
