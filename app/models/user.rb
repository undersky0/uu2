class User < ActiveRecord::Base
  acts_as_authorization_subject  :association_name => :roles
  include Scrubber
  
has_many :authentications, :dependent => :delete_all
def apply_omniauth(auth)
  # In previous omniauth, 'user_info' was used in place of 'raw_info'
  self.email = auth['extra']['raw_info']['email']
  # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
  authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
end
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :photo_attributes, :email, :password, :password_confirmation, :remember_me, :scribbles_attributes, :profile_attributes, :location_attributes
  # attr_accessible :title, :body
  
  has_one :avatar, :as => :avatarable, :dependent => :destroy
  accepts_nested_attributes_for :avatar
  
  
  
  
  has_one :profile,
          dependent: :destroy
          accepts_nested_attributes_for :profile
  
  has_one :location,
  dependent: :destroy
  accepts_nested_attributes_for :location
  
  
  has_many :scribbles, :as => :scribbled, dependent: :destroy
  accepts_nested_attributes_for :scribbles
  
  has_many :comments, :as => :commentable
  
  has_many :memberships, dependent: :destroy
  has_many :groups, :through => :memberships
  
  
  
  #user.places , location.places, user.locations
  # has_many :locations, :through => :places, :primary_key => 'user_id'
  # has_many :places, :as => :locationable, :primary_key => 'user_id'
#   
  

  # accepts_nested_attributes_for :locations
  
  # @user = User.find(params[:id]) # finds user
  # @commentable = @user # find the right link with commentable
  # @comments = @commentable.comments # finds the associated comments
  # @comment = Comment.new 
  
  before_save :create_actor_id  
  #self.primary_key = 'actor_id'
  
  
  has_many :friendship
  
  has_many :friends,
           :through => :friendship,
           :source => :friend,
           :conditions => "status = 'accepted'",
           :order => :created_at
  
  
  has_many :requested_friends,
           :through => :friendship,
           :source => :friend,
           :conditions => "status = 'requested'",
           :order => :created_at
           
  has_many :pending_friends,
           :through => :friendship,
           :source => :friend,
           :conditions => "status = 'pending'",
           :order => :created_at
           
  # has_many :neighbours,
           # :through => :friendships,
           # :source => :friend,
           # :conditions => :location
           
has_many :messages, class_name: 'Message', foreign_key: 'user_id'    
    
    after_initialize :create_profile
    after_initialize :create_location
           
  def unread_messages?
    unread_messages_count > 0 ? true : false
  end
     
           
  def create_actor_id
    begin
      self.actor_id = SecureRandom.base64(8)
    end while self.class.exists?(:actor_id => actor_id)
    end       
  def prefix
    try(:full_name) || email
  end
def message_title
    "#{prefix} <#{email}>"
end

def mailbox
  mailbox.new(self)
end
  
  def full_name
    @profile = self.profile
    return "#{@profile.firstname} #{@profile.lastname}"
  end
  
  def create_profile
    self.build_profile() if self.profile.nil?
  end      
  def create_location
    self.build_location() if self.location.nil?
  end
  
  
  def joined?(group)
    self.memberships.find_by_group_id(group)
  end    
  
  
  def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_create.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    #user.profile.firstname = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    #user.save!
    end
  end
  
  def self.new_with_session(params, session)
  if session["devise.user_attributes"]
    new(session["devise.user_attributes"], without_protection: true) do |user|
      user.attributes = params
      user.valid?
    end
  else
    super
  end    

  end
  
  def password_required?
  super && provider.blank?
  end
  
def update_with_password(params, *options)
  if encrypted_password.blank?
    update_attributes(params, *options)
  else
    super
  end
end


  end
  
  
