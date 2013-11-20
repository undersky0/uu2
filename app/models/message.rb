class Message < ActiveRecord::Base
  attr_accessible :body, :read_at, :recepient_id, :sender_id
  attr_accessor :reply, :parent
  
  
  belongs_to :sender,
  :class_name => 'User',
  :primary_key => 'actor_id',
  :foreign_key => 'sender_id'
  
  belongs_to :recepient,
  :class_name => 'User',
  :primary_key => 'actor_id',
  :foreign_key => 'recepient_id'
  
  belongs_to :chat 
  before_create :assign_to_chat
  after_create :save_recipient, :save_replied_to
  
  def self.readinmessage(id, reader)
    message = find(id, :conditions => ["sender_id = ? OR recepient_id = ?", reader, reader])
    if message.read_at.nil? && (message.recepient.actor_id == reader)
      message.read_at = Time.now
      message.save!
    end
  end
  def read?
      self.read_at.nil? ?false : true
  end
  
  
  def message_read?
    !recipient_read_at.nil?
  end
  
  def mark_message_as_read(time = Time.now)
    self.recipient_read_at = time
    save!
  end
  
  def new_message?(actor)
    not message_read? and actor != sender  
  end
  
  def parent
    return @parent unless @parent.nil?
    return Message.find(parent_id) unless parent_id.nil?
  end
  
  def parent=(message)
    self.parent_id = message.id
    @parent = message
  end
  
  def other_actor(actor)
    actor == sender ? recipient : sender
  end
  
  def message_trashed?(actor)
    case actor
    when sender
      !sender_deleted_at.nil? and sender_deleted_at > 1.year.ago
    when recipient
      self.recipient_deleted_at = time
    end
    save!
  end
  
  def untrash_message(actor)
    return false unless message_trashed?(actor)
    trash_message(actor, nil)
    
  end
  
  def replay?
    (!parent.nil? or !parent_id.nil?) and assign_replay_pair_valid?
  end
  
  def replied_to?
    !replied_at.nil?
  end
  
  def assign_replay_pair_valid?
    Set.new([sender, recipient]) == Set.new([parent.sender, parent.recipient])
    
  end
  
  def valid_replay_pair?(actor, other)
    ((recipient == actor and sender == other)) or (recipient == other and seder == actor)
  end
  private 
  def assign_to_chat
  self.chat = parent.nil? Chat.create :parent.chat
  end 
  
  def save_recipient
    self.recipient.save!
  end
  
  def save_replied_to
    if replay?
      parent.replied_at = Time.now
      parent.save!
    
    end
  end
end
