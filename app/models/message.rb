require 'message_sender'
class Message < ActiveRecord::Base
  has_ancestry
  attr_accessor :draft
  serialize :recipient_ids, Array 
  
  belongs_to :user
  
  validates :body, :user_id, presence: true
  validate :locak_down_attributes, on: :update
  
  scope :ordered,   -> {order('created_at asc')}
  scope :active,    -> { not_trashed.not_deleted}
  
  scope :draft,     -> { where('sent_at is NULL')}
  scope :not_draft, -> { where('sent_at is not NULL')}
  
  scope :sent,      -> { where('sent_at is not NULL')}
  scope :unsent,    -> { where('sent_at is NULL') }
  
  scope :received,  -> { where('received_at is not NULL')}
  scope :not_received, -> { where('received_at is NULL')}
  
  scope :trashed,   -> { where('trashed_at is not NULL')}
  scope :not_trashed, -> { where('trashed_at is NULL')}
  
  scope :deleted,   -> {where ('deleted_at is not NULL' )}
  scope :not_deleted, -> {where ('deleted_at is NULL')}
  
  scope :by_user, lambda { |user| where(user_id: user.id) }
  scope :inbox,   lambda { |user| by_user(user).active.received }
  scope :outbox,  lambda { |user| by_user(user).active.sent }
  scope :drafts,  lambda { |user| by_user(user).active.draft.not_received }
  scope :trash,   lambda { |user| by_user(user).trashed.not_deleted }

  scope :read,    lambda { |user| by_user(user).where('read_at is not NULL').received }
  scope :unread,  lambda { |user| by_user(user).where('read_at is NULL').received }

  
    
  attr_accessible :body, :read_at, :recepient_id, :sender_id, :profile_name, :profile_firstname, :recipient_ids, :draft, :user, :received_at, :editable
  attr_accessor :reply, :parent, :profile
  
  
  def active?
    !trashed? && !deleted?
  end
  
  def sender=sending_user
    user = sending_user
  end
  
  def sender
    sent? ? user : parent.user
  end
  
  def recipients
    sent? ? children.collect(&:user) : parent.recipients
  end
  
  def recipients= users
    users.each {|u| recipients_ids << u.id}
    
  end
  
  def recipient_list
    recipient_ids.reject(&:blank?).map {|id| User.find id}
  end
  
  def mailbox
    case
    when sent? then :outbox
    when received? then :inbox
    when !new_record? && unsent? then :drafts
    when trashed? then :trash
    else
      :compose
  end
  end
  
  def send!
    lock.synchronize do 
      MessageSender.new(self).run unless draft?
    end
  end
  
  def replay! options={}
    if parent
      replay = children.create!(subject: options.fetch(:subject, subject),
      body: options.fetch(:body, nil),
      user: user,
      recipients: [parent.user])
      replay.send!
    end
  end
  
  def receive!
    update(received_at: Time.zone.now)
  end
  def read!
    update(read_at: Time.zone.now) unless self.read_at.present?
  end
  
  def trash!
    update(trashed_at: Time.zone.now)
  end
  def deleted!
    update(deleted_at: Time.zone.now)
  end
  
  %W[sent received trashed deleted read].each do |act|
    define_method "#{act}?" do
      self.send(:"#{act}_at").present?
    end
    end
      
      def unread?
        !read?
      end
      
      def uneditable?
        !editable?
      end
      def unsent?
        !sent?
      end
      def draft?
        self.draft == '1'
      end
      def sent_date
        sent_at || received_at
      end
      
      private
      def lock_down_attributes
        return if editable?
        errors.add(:base, 'Cannot edit') unless deleted_at_changed? || trashed_at_changed? || read_at_changed?
      end
      def lock
        @lock ||= Mutex.new
      end
end









